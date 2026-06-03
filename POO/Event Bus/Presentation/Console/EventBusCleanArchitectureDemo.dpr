program EventBusCleanArchitectureDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Devspace.Application.EventBus.Event in '..\..\Application\EventBus\Devspace.Application.EventBus.Event.pas',
  Devspace.Application.EventBus.Callback in '..\..\Application\EventBus\Devspace.Application.EventBus.Callback.pas',
  Devspace.Application.EventBus.Subscription in '..\..\Application\EventBus\Devspace.Application.EventBus.Subscription.pas',
  Devspace.Application.EventBus.Intf in '..\..\Application\EventBus\Devspace.Application.EventBus.Intf.pas',
  Devspace.Domain.Events.OrderCreated in '..\..\Domain\Events\Devspace.Domain.Events.OrderCreated.pas',
  Devspace.Application.EventBus.Facade in '..\..\Application\EventBus\Devspace.Application.EventBus.Facade.pas',
  Devspace.Domain.Events.PaymentApproved in '..\..\Domain\Events\Devspace.Domain.Events.PaymentApproved.pas',
  Devspace.Infrastructure.EventBus.Event.Base in '..\..\Infraestructure\EventBus\Devspace.Infrastructure.EventBus.Event.Base.pas',
  Devspace.Infrastructure.Events.OrderCreated in '..\..\Infraestructure\Events\Devspace.Infrastructure.Events.OrderCreated.pas',
  Devspace.Infrastructure.Events.PaymentApproved in '..\..\Infraestructure\Events\Devspace.Infrastructure.Events.PaymentApproved.pas',
  Devspace.Infrastructure.EventBus.Subscription.Base in '..\..\Infraestructure\EventBus\Devspace.Infrastructure.EventBus.Subscription.Base.pas',
  Devspace.Infrastructure.EventBus.Subscription.Intf in '..\..\Infraestructure\EventBus\Devspace.Infrastructure.EventBus.Subscription.Intf.pas',
  Devspace.Infrastructure.EventBus.Subscription.Typed in '..\..\Infraestructure\EventBus\Devspace.Infrastructure.EventBus.Subscription.Typed.pas',
  Devspace.Infrastructure.EventBus in '..\..\Infraestructure\EventBus\Devspace.Infrastructure.EventBus.pas',
  Devspace.Application.UseCases.CreateOrder in '..\..\Application\UseCases\Devspace.Application.UseCases.CreateOrder.pas',
  Devspace.Application.Subscribers.Order in '..\..\Application\Subscribers\Devspace.Application.Subscribers.Order.pas';

var
  EventBus: IEventBus;
  CreateOrderUseCase: TCreateOrderUseCase;

begin
  try
    EventBus := TEventBus.New;
    TOrderSubscribers.Register(EventBus);
    CreateOrderUseCase := TCreateOrderUseCase.Create(EventBus);

    try
      CreateOrderUseCase.Execute('CUS-001', 1299.90);
    finally
      CreateOrderUseCase.Free;
    end;

    Writeln;
    Writeln('Aguardando eventos assíncronos...');
    Sleep(1000);
    Writeln;
    Writeln('Processamento concluído.');
    Readln;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName + ': ' + E.Message);
      Readln;
    end;
  end;
end.

