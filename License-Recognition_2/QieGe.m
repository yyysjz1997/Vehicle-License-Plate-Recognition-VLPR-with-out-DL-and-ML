function e=QieGe(sbw)
[m,n]=size(sbw);
top=1;bottom=m;left=1;right=n;   % init
while sum(sbw(top,:))==0 && top<=m %A(:,i)=[x x x x x ... x];i����ֵ��������x����Ҫ����ֵ
    top=top+1;
end
while sum(sbw(bottom,:))==0 && bottom>=1
    bottom=bottom-1;
end
while sum(sbw(:,left))==0 && left<=n
    left=left+1;
end
while sum(sbw(:,right))==0 && right>=1
    right=right-1;
end
dd=right-left;
hh=bottom-top;
e=imcrop(sbw,[left top dd hh]);%imcrop('ͼ����',[x��㣬y��㣬x��ȣ�y���])
