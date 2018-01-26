function [loop,lim] = hystFit(name,n,res)
res=res/4;
show=true;
D = importdata(name);
Vc = D(:,3);
Vs = D(:,2);
if show
    findpeaks(Vs,'MinPeakDistance',100)
end
[~,pks]=findpeaks(Vs,'MinPeakDistance',100);

Vst2=Vs(pks(3):pks(4));
Vct2=Vc(pks(3):pks(4));

Vst1=Vs(pks(4):pks(5));
Vct1=Vc(pks(4):pks(5));

Vsb1=Vs(pks(5):pks(6));
Vcb1=Vc(pks(5):pks(6));

Vsb2=Vs(pks(6):pks(7));
Vcb2=Vc(pks(6):pks(7));
F=cell(2,2);
p=polyfit(Vst1,Vct1,n);
F(1,1)={@(B) polyval(p,B)};
p=polyfit(Vsb1,Vcb1,n);
F(2,1)={@(B) polyval(p,B)};

p=polyfit(Vst2,Vct2,n);
F(1,2)={@(B) polyval(p,B)};
p=polyfit(Vsb2,Vcb2,n);
F(2,2)={@(B) polyval(p,B)};

vst1=linspace(min(Vst1),max(Vst1),res);
vsb1=linspace(min(Vsb1),min(Vsb2),res);
vst2=linspace(max(Vst1),max(Vst2),res);
vsb2=linspace(max(Vsb1),max(Vsb2),res);
loop=[F{1,1}(vst1),F{1,2}(vst2);F{2,1}(vsb1),F{2,2}(vsb2)];
lim=[min(Vst1),max(Vst2);min(Vsb1),max(Vst2)];
if show
    figure(2)
    line(Vs,Vc);
    hold on
    %     plot(Vsb1,Vcb1,'-g');
    %     plot(Vst1,Vct1,'-r');
    %     plot(Vst2,Vct2,'-m');
    %     plot(Vsb2,Vcb2,'-k');
    plot(vst1,F{1,1}(vst1),'-b');
    plot(vsb1,F{2,1}(vsb1),'-r');
    plot(vst2,F{1,2}(vst2),'-b');
    plot(vsb2,F{2,2}(vsb2),'-r');
end
end