program Bridge;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type

  ///implementator
  TDrawingAPI = class abstract
    procedure DrawCircle(x, y, radius: double); virtual; abstract;
  end;

  //ConcreteImplementator 1
  TDeawingAPI1 = class(TDrawingAPI)
    procedure DrawCircle(x, y, radius: double); override;
  end;

 //ConcreteImplementator 2
  TDeawingAPI2 = class(TDrawingAPI)
    procedure DrawCircle(x, y, radius: double);override;
  end;

  //Abstraction
  TShape = class abstract
    procedure Draw();virtual; abstract;// low-level (i.e. Implementation-specific)
    procedure ResizeByPercentage(pct: double);virtual; abstract;// high-level (i.e. Abstraction-specific)
  end;

  //Refined Abstraction
  TCircleShape = class(TShape)
    strict private
      x, y, radius: double;
      drawingAPI: TDrawingAPI;
    public
      constructor Create(x, y, radius: double; drawingAPI: TDrawingAPI);
      procedure Draw;override;
      procedure ResizeByPercentage(pct: double);override;
  end;

{ TDeawingAPI1 }

procedure TDeawingAPI1.DrawCircle(x, y, radius: double);
begin
  WriteLn('API1.circle at '+FloatToStr(x)+' : '+FloatToStr(y)+' radius '+FloatToStr(radius));
end;

{ TDeawingAPI }

procedure TDeawingAPI2.DrawCircle(x, y, radius: double);
begin
  WriteLn('API2.circle at '+FloatToStr(x)+' : '+FloatToStr(y)+' radius '+FloatToStr(radius));
end;

{ TCircleShape }

constructor TCircleShape.Create(x, y, radius: double; drawingAPI: TDrawingAPI);
begin
  self.x := x;
  self.y := y;
  self.radius := radius;
  self.drawingAPI := drawingAPI;
end;

procedure TCircleShape.Draw;
begin
  drawingAPI.DrawCircle(x, y, radius);
end;

procedure TCircleShape.ResizeByPercentage(pct: double);
begin
  radius := radius * pct;
end;

var shapes: array of TShape;
    shape: TShape;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    SetLength(shapes, 2);
    shapes[0] := TCircleShape.Create(1, 2, 3, TDeawingAPI1.Create);
    shapes[1] := TCircleShape.Create(5, 7, 11, TDeawingAPI2.Create);

    for shape in shapes do
    begin
       shape.ResizeByPercentage(2.5);
       shape.Draw;
    end;

    WriteLn(#13#10+'Press any key to continue..');
    ReadLn;

    shapes[0].Free;
    shapes[1].Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
