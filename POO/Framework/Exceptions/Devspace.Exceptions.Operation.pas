unit Devspace.Exceptions.Operation;

interface

uses
  System.SysUtils;

type
  EDivByZeroHelper = class helper for EDivByZero
  public
    class procedure RaiseCannotBeZeroException(const AProperty: string);
  end;

  EOnErrorException = class(Exception)
  public
    class procedure RaiseOnErrorCallbackNotAssignedException;
  end;

implementation

uses
  Devspace.Consts.Operation;

{ EDivByZeroHelper }

class procedure EDivByZeroHelper.RaiseCannotBeZeroException(const AProperty: string);
begin
  raise EDivByZero.Create(Format(ValueCannotBeZeroException, [AProperty]));
end;

{ EOnErrorException }

class procedure EOnErrorException.RaiseOnErrorCallbackNotAssignedException;
begin
  raise EOnErrorException.Create(ErrorCallbackNotAssignedMessage);
end;

end.
