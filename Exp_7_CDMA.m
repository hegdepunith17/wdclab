%CDMA.
clc;
clear all;
close all;
bits = [5 10 2 3];
walsh = [1 -1 -1 1; 1 1 -1 -1; 1 -1 1 -1; 1 1 1 1];
d = zeros(1,4);
encrypt = zeros(4,4);
for i = 1:4
    for j = 1:4
        encrypt(i,j) = bits(i)*walsh(i,j);
        d(j) = d(j)+encrypt(i,j);
    end
end

figure(1);
subplot(4,4,1);
stairs(encrypt(1,:));
title('Station 1 code');
xlim([1 5]);
ylim([-6 6]);
grid();

subplot(4,4,2);
stairs(encrypt(2,:));
title('Station 2 code');
xlim([1 5]);
ylim([-11 11]);
grid();

subplot(4,4,5);
stairs(encrypt(3,:));
title('Station 3 code');
xlim([1 5]);
ylim([-3 3]);
grid();

subplot(4,4,6);
stairs(encrypt(4,:));
title('Station 4 code');
xlim([1 5]);
ylim([-4 4]);
grid();

subplot(2,2,2);
stairs(d);
title('Multiplexed channel data');
xlim([1 5]);
ylim([-11 21]);
grid();

demux = [0 0 0 0];
inner = zeros(4,4);
for i = 1:4
    for j = 1:4
        inner(i,j) = d(j)*walsh(i,j);
        demux(i) = demux(i)+d(j)*walsh(i,j);
    end
end
demux = demux/4;

subplot(4,4,9);
stairs(inner(1,:));
title('Inner Product 1');
xlim([1 5]);
ylim([-7 21]);
grid();

subplot(4,4,10);
stairs(inner(2,:));
title('Inner Product 2');
xlim([1 5]);
ylim([-1 21]);
grid();

subplot(4,4,13);
stairs(inner(3,:));
title('Inner Product 3');
xlim([1 5]);
ylim([-11 21]);
grid();

subplot(4,4,14);
stairs(inner(4,:));
title('Inner Product 4');
xlim([1 5]);
ylim([-11 21]);
grid();

subplot(2,2,4);
stairs(demux);
title('Demultiplexed output');
xlim([1 5]);
ylim([-1 20]);
grid();