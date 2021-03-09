
% Demo of using different line codings
bits = [1 0 1 1 0 0 1 1];
bitrate = 1; % bits per second

figure;
[t,s] = unrz(bits,bitrate);
plot(t,s,'LineWidth',3);
axis([0 t(end) -0.1 1.1])
grid on;
title(['Unipolar NRZ: [' num2str(bits) ']']);

figure;
[t,s] = urz(bits,bitrate);
plot(t,s,'LineWidth',3);
axis([0 t(end) -0.1 1.1])
grid on;
title(['Unipolar RZ: [' num2str(bits) ']']);

figure;
[t,s] = prz(bits,bitrate);
plot(t,s,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;
title(['Polar RZ: [' num2str(bits) ']']);

figure;
[t,s] = pnrz(bits,bitrate);
plot(t,s,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;
title(['Polar NRZ: [' num2str(bits) ']']);

figure;
[t,s] = bpnrz(bits,bitrate);
plot(t,s,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;
title(['Bi-Polar NRZ: [' num2str(bits) ']']);

figure;
[t,s] = bprz(bits,bitrate);
plot(t,s,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;
title(['Bi-Polar RZ: [' num2str(bits) ']']);

figure;
[t,s] = manchester(bits,bitrate);
plot(t,s,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;
title(['Manchester: [' num2str(bits) ']']);


function [t,x] = urz(bits, bitrate)
% URZ Encode bit string using unipolar RZ code.
%   [T, X] = URZ(BITS, BITRATE) encodes BITS array using unipolar RZ
%   code with given BITRATE. Outputs are time T and encoded signal
%   values X.
T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); % output signal
for i = 0:length(bits)-1
  if bits(i+1) == 1
    x(i*n+1:(i+0.5)*n) = 1;
    x((i+0.5)*n+1:(i+1)*n) = 0;
  else
    x(i*n+1:(i+1)*n) = 0;
  end
end
end

function [t,x] = unrz(bits, bitrate)
T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); % output signal
for i = 0:length(bits)-1
  if bits(i+1) == 1
    x(i*n+1:(i+1)*n) = 1;
  else
    x(i*n+1:(i+1)*n) = 0;
  end
end
end


function [t,x] = prz(bits, bitrate)
T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); % output signal
for i = 0:length(bits)-1
  if bits(i+1) == 1
    x(i*n+1:(i+0.5)*n) = 1;
    x((i+0.5)*n+1:(i+1)*n) = 0;
  else
    x(i*n+1:(i+0.5)*n) = -1;
    x((i+0.5)*n+1:(i+1)*n) = 0;
  end
end
end



function [t,x] = pnrz(bits, bitrate)
T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); % output signal
for i = 0:length(bits)-1
  if bits(i+1) == 1
    x(i*n+1:(i+1)*n) = 1;
  else
    x(i*n+1:(i+1)*n) = -1;
  end
end
end


function [t,x] = bpnrz(bits, bitrate)
T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); % output signal
j=0;
for i = 0:length(bits)-1
  if bits(i+1) == 1
    j = j+1;
    if (-1)^j == 1
      x(i*n+1:(i+1)*n) = 1;
    else
      x(i*n+1:(i+1)*n) = -1;
    end
  else
    x(i*n+1:(i+1)*n) = 0;
  end
end
end


function [t,x] = bprz(bits, bitrate)
T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); % output signal
j=0;
for i = 0:length(bits)-1
  if bits(i+1) == 1
    j = j+1;
    if (-1)^j == 1
      x(i*n+1:(i+0.5)*n) = 1;
      x((i+0.5)*n+1:(i+1)*n) = 0;
    else
      x(i*n+1:(i+0.5)*n) = -1;
      x((i+0.5)*n+1:(i+1)*n) = 0;
    end
  else
    x(i*n+1:(i+1)*n) = 0;
  end
end
end


function [t,x] = manchester(bits, bitrate)
T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); % output signal
for i = 0:length(bits)-1
  if bits(i+1) == 1
    x(i*n+1:(i+0.5)*n) = 1;
    x((i+0.5)*n+1:(i+1)*n) = -1;
  else
    x(i*n+1:(i+0.5)*n) = -1;
    x((i+0.5)*n+1:(i+1)*n) = 1;
  end
end
end