unit Devspace.Infrastructure.EventBus;

interface

uses
  System.Generics.Collections,
  System.SyncObjs,
  System.SysUtils,
  Devspace.Application.EventBus.Event,
  Devspace.Application.EventBus.Callback,
  Devspace.Application.EventBus.Intf,
  Devspace.Application.EventBus.Subscription,
  Devspace.Infrastructure.EventBus.Subscription.Intf;

type
  TEventBus = class(TInterfacedObject, IEventBus)
  strict private
    FSubscriptions: TList<IEventSubscriptionInternal>;
    FLock: TCriticalSection;
    constructor Create;
    function Snapshot: TArray<IEventSubscriptionInternal>;
    procedure DispatchAsync(const ASubscription: IEventSubscriptionInternal; const AEvent: IEvent);
    class function CreateAsyncDispatchProc(const ASubscription: IEventSubscriptionInternal; const AEvent: IEvent): TProc; static;
  public
    destructor Destroy; override;
    class function New: IEventBus;
    function Subscribe(const AEventGuid: TGUID; const ACallback: TEventCallback): IEventSubscription;
    function Publish(const AEvent: IEvent): IEventBus;
    function PublishAsync(const AEvent: IEvent): IEventBus;
    function Unsubscribe(const ASubscription: IEventSubscription): IEventBus;
  end;

implementation

uses
  System.Classes,
  System.Threading,
  Devspace.Infrastructure.EventBus.Subscription.Typed;

{ TEventBus }

constructor TEventBus.Create;
begin
  inherited Create;
  FSubscriptions := TList<IEventSubscriptionInternal>.Create;
  FLock := TCriticalSection.Create;
end;

destructor TEventBus.Destroy;
begin
  FLock.Free;
  FSubscriptions.Free;
  inherited;
end;

class function TEventBus.New: IEventBus;
begin
  Result := TEventBus.Create;
end;

function TEventBus.Snapshot: TArray<IEventSubscriptionInternal>;
begin
  FLock.Enter;
  try
    Result := FSubscriptions.ToArray;
  finally
    FLock.Leave;
  end;
end;

function TEventBus.Subscribe(const AEventGuid: TGUID; const ACallback: TEventCallback): IEventSubscription;
var
  Subscription: IEventSubscriptionInternal;
begin
  Subscription := TEventSubscription.Create(AEventGuid, ACallback);

  FLock.Enter;
  try
    FSubscriptions.Add(Subscription);
  finally
    FLock.Leave;
  end;

  Result := Subscription;
end;

function TEventBus.Publish(const AEvent: IEvent): IEventBus;
var
  Subscription: IEventSubscriptionInternal;
  Items: TArray<IEventSubscriptionInternal>;
begin
  Result := Self;

  if not Assigned(AEvent) then
  begin
    Exit;
  end;

  Items := Snapshot;

  for Subscription in Items do
  begin
    if Subscription.SupportsEvent(AEvent) then
    begin
      Subscription.Dispatch(AEvent);
    end;
  end;
end;

function TEventBus.PublishAsync(const AEvent: IEvent): IEventBus;
var
  Subscription: IEventSubscriptionInternal;
  Items: TArray<IEventSubscriptionInternal>;
begin
  Result := Self;

  if not Assigned(AEvent) then
  begin
    Exit;
  end;

  Items := Snapshot;

  for Subscription in Items do
  begin
    if Subscription.SupportsEvent(AEvent) then
    begin
      TTask.Run(TEventBus.CreateAsyncDispatchProc(Subscription, AEvent));
    end;
  end;
end;

procedure TEventBus.DispatchAsync(const ASubscription: IEventSubscriptionInternal; const AEvent: IEvent);
var
  LocalSubscription: IEventSubscriptionInternal;
  LocalEvent: IEvent;
begin
  LocalSubscription := ASubscription;
  LocalEvent := AEvent;

  TTask.Run(
    procedure
    begin
      LocalSubscription.Dispatch(LocalEvent);
    end);
end;

function TEventBus.Unsubscribe(const ASubscription: IEventSubscription): IEventBus;
var
  Index: Integer;
begin
  Result := Self;

  if not Assigned(ASubscription) then
  begin
    Exit;
  end;

  FLock.Enter;

  try
    for Index := Pred(FSubscriptions.Count) downto 0 do
    begin
      if SameText(FSubscriptions[Index].Id, ASubscription.Id) then
      begin
        FSubscriptions.Delete(Index);
        Break;
      end;
    end;
  finally
    FLock.Leave;
  end;
end;

class function TEventBus.CreateAsyncDispatchProc(const ASubscription: IEventSubscriptionInternal; const AEvent: IEvent): TProc;
var
  SubscriptionRef: IEventSubscriptionInternal;
  EventRef: IEvent;
begin
  SubscriptionRef := ASubscription;
  EventRef := AEvent;

  Result :=
    procedure
    begin
      SubscriptionRef.Dispatch(EventRef);
    end;
end;

end.

