X_update = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
N_particles = 4000;
Xstd_rgb = 50;
Xpos = 25; % maximum deviation in location
Xvec = 5;  % maximum deviation in velocity
Xrgb_trgt = [255; 0; 0]; % to track red color
obj = mmreader('sample.avi');
%nFrames = obj.NumberOfFrames;
nFrames = floor(obj.Duration * obj.FrameRate);
vidHeight = obj.Height;
vidWidth = obj.Width;
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
X1 = randi(vidHeight, 1, N_particles);% initialisation of random values of x coordinate to n particles
X2 = randi(vidWidth, 1, N_particles); % initialisation of random values of y coordinate to n particles
X3 = zeros(2, N_particles);           % initialisation of velocities in x and y direction to n particles
X = [X1; X2; X3];



for k = 1 : nFrames
    mov(k).cdata = read(obj, k);
    
    
    X = X_update * X ;
    X(1:2,:) = X(1:2,:) + Xpos * randn(2, N_particles);%errors in gaussian transition
    X(3:4,:) = X(3:4,:) + Xvec * randn(2, N_particles);%errors in gaussian transition
    
   %position(k,:,:)= X;
    L = zeros(1,N_particles);
    Y = permute(mov(k).cdata, [3 1 2]); % rearranging red green and blue frames in a different way

    A = -log(sqrt(2 * pi) * Xstd_rgb);
    B = - 0.5 / (Xstd_rgb.^2);

    X = round(X); % to provide integer value to error introduced in transition of x

  for j = 1:N_particles
    
     m = X(1,j);  % x coorinate of jth particle
     n = X(2,j);  % y coorinate of jth particle
    
     I = (m >= 1 & m <= vidHeight);
     J = (n >= 1 & n <= vidWidth);
    
     if I && J   % if particle is lying with in frame then excess it
        
        C = double(Y(:, m, n)); % taking red green and blue component value at x,y location
        
        D = C - Xrgb_trgt;      % deviation of a particle from red color
        
        D2 = D' * D;
        
        L(j) =  A + B * D2;
     else
        
        L(j) = -Inf; % if particle is not in frame assign it minus infinite
     end
  end
  L = exp(L - max(L));% Assing values to particles according to deviation from tracking color
  
normL = L / sum(L, 2);% normalise the assigned values
R = cumsum(normL, 2);
T = rand(1, N_particles);
[zz I] = histc(T, R);   % zz value is ignored and not used anywhere

X = X(:, I + 1);
 
figure(1)
image(mov(k).cdata)
title('+++ Particles tracking red object +++')

hold on
plot(X(2,:), X(1,:), '.')
hold off

drawnow

X_mean = mean(X, 2);

figure(2)
image(mov(k).cdata)
title('+++ Showing mean value +++')

hold on
plot(X_mean(2,:), X_mean(1,:), '--rs', 'MarkerSize', 64, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'n')
hold off

drawnow
end