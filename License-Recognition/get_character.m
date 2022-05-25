function characters = get_character(image,mode)
if strcmp(mode,'loose')
    pixes=15;
    l=1.7;
    r=2.3;
elseif strcmp(mode,'tight')
    pixes=6;
    l=1.2;
    r=2.8;
end
stat=regionprops(image);
bbox=[];
for i=1:length(stat)
    bbox=[bbox;stat(i).BoundingBox];
end
for i=1:length(bbox)
    characters=[];
    if bbox(i,4)/bbox(i,3)>l&&bbox(i,4)/bbox(i,3)<r
        characters=bbox(i,:);
    end
    for j=1:length(bbox)
        if (i~=j)&&(abs(bbox(i,3)-bbox(j,3))+abs(bbox(i,4)-bbox(j,4)))<pixes&&bbox(j,4)/bbox(j,3)>l&&bbox(j,4)/bbox(j,3)<r
            characters=[characters;bbox(j,:)];
        end
    end
    if size(characters,1)>2
        break;
    end
end

height=mean(characters(:,4));
width=mean(characters(:,3));
for i=1:length(bbox)
    if abs(bbox(i,4)-height)<pixes&&bbox(i,3)<width*0.9&&bbox(i,1)>characters(1,1)
        space=int16((width-bbox(i,3))/2);
        bbox(i,1)=bbox(i,1)-space;
        bbox(i,3)=int16(width);
        if bbox(i,1)>0
            characters=[characters;bbox(i,:)];
        end
    end
end
characters=sortrows(characters,1);
end

