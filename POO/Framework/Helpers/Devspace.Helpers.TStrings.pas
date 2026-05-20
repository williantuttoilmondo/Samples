unit Devspace.Helpers.TStrings;

interface

uses
  System.Classes;

type
  TStringsHelper = class helper for TStrings
  public
    function FromArray(const AValues: TArray<string>): TStrings;
  end;

implementation

{ TStringsHelper }

function TStringsHelper.FromArray(const AValues: TArray<string>): TStrings;
var
  Value: string;
begin
  Result := Self;
  Result.Clear;

  for Value in AValues do
  begin
    Result.Add(Value);
  end;
end;

end.
