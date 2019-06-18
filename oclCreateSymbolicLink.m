function oclCreateSymbolicLink(serial_link)

  for k=1:length(serial_link.links)
    l = serial_link.links(k);
    if ~isempty(l.theta)
        l.theta = 0*CasadiVariable.Matrix([1 1]) + l.theta;
    end
    if ~isempty(l.d)
        l.d = 0*CasadiVariable.Matrix([1 1]) + l.d;
    end
    l.alpha = 0*CasadiVariable.Matrix([1 1]) + l.alpha;
    l.a = 0*CasadiVariable.Matrix([1 1]) + l.a;
    l.offset = 0*CasadiVariable.Matrix([1 1]) + l.offset;

    l.I = 0*CasadiVariable.Matrix([1 1]) + l.I;
    l.r = 0*CasadiVariable.Matrix([1 3]) + l.r;
    l.m = 0*CasadiVariable.Matrix([1 1]) + l.m;

    l.Jm = 0*CasadiVariable.Matrix([1 1]) + l.Jm;
    l.G = 0*CasadiVariable.Matrix([1 1]) + l.G;
    l.B = 0*CasadiVariable.Matrix([1 1]) + l.B;
%     l.Tc = 0*CasadiVariable.Matrix([1 2]) + l.Tc;
  end
end