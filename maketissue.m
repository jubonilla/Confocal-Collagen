% maketissue.m
%   Creates a cube of optical property pointers,T(y,x,z), saved in
%       myname_T.bin = a tissue structure file
%   which specifies a complex tissue for use by mcxyz.c.
%
%   Also prepares a listing of the optical properties at chosen wavelength
%   for use by mcxyz.c, [mua, mus, g], for each tissue type specified
%   in myname_T.bin. This listing is saved in
%       myname_H.mci = the input file for use by mcxyz.c.

clear, 
format compact 
clc
home

myname      = 'skinvessel';
time_min    = 2;      	% time duration of the simulation [min] <----- run time -----
nm          = 520;   	% desired wavelength of simulation
Nbins       = 700;    	% # of bins in each dimension of cube (deberia hacerse de 500)
binsize     = 0.0003; 	% size of each bin, eg. [cm] or [mm] (deberia hacerse de 0.002)

% Set position of focus, so mcxyz can calculate launch trajectory
xfocus      = 0;        % set x,position of focus
yfocus      = 0;        % set y,position of focus
zfocus      = 0.065;    	% set z,position of focus

radius      = 1.00;   % 1/e radius of beam at tissue surface
waist       = 0.315;  	% 1/e radius of beam at focus

ux0         = 0.1;      % trajectory projected onto x axis
uy0         = 0.1;      % trajectory projected onto y axis
uz0         = sqrt(1 - ux0^2 - uy0^2); % such that ux^2 + uy^2 + uz^2 = 1

% Create tissue properties
%[1/cm]
muav(1)  = 41; musv(1)  = 500; gv(1)    = 0.95;
muav(2)  = 9.9; musv(2)  = 99; gv(2)    = 0.9;

% Specify Monte Carlo parameters    
Nx = Nbins;
Ny = Nbins;
Nz = Nbins;
dx = binsize;
dy = binsize;
dz = binsize;
x  = ([1:Nx]'-Nx/2)*dx;
y  = ([1:Ny]'-Ny/2)*dy;
z  = [1:Nz]'*dz;
zmin = min(z);
zmax = max(z);
xmin = min(x);
xmax = max(x);
ymin = min(y);
ymax = max(y);

if isinf(zfocus), zfocus = 1e12; end

% CREATE TISSUE STRUCTURE T(y,x,z)
%   Create T(y,x,z) by specifying a tissue type (an integer)
%   for each voxel in T.
%
%   Note: one need not use every tissue type in the tissue list.
%   The tissue list is a library of possible tissue types.

T = double(zeros(Nx,Ny,Nz)); 

for iy=1:Ny
    for iz=1:Nz
        x=rand;
        if x<0.79
            select=1;
        else
            select=2;
        end
        T(:, iy, iz)= select;
    end%iy
end %iz    
  
%Create 3D voxel graphics of propagationmedium
%load mri.mat
%D = squeeze(T);
%h = vol3d('cdata',D,'texture','3D');
%view(3);  
%vol3d(h);  
%axis tight;  daspect([1 1 1]);
%alphamap('rampup');
%alpha(0.95);
%color =[0 51 85; 226 236 231]/255;
%colormap(color);
%xlabel('N_x','FontSize',14);
%ylabel('N_y','FontSize',14); 
%zlabel('N_z','FontSize',14);


tic
    % convert T to linear array of integer values, v(i)i = 0;
    v = uint8(reshape(T,Nx*Ny*Nz,1));
    %% WRITE FILES
    % Write myname_H.mci file
    %   which contains the Monte Carlo simulation parameters
    %   and specifies the tissue optical properties for each tissue type.
    commandwindow
    disp(fprintf('--------create %s --------',myname))
    filename = sprintf('%s_H.mci',myname);
    fid = fopen(filename,'w');
        % run parameters
        fprintf(fid,'%0.2f\n',time_min);
        fprintf(fid,'%d\n'   ,Nx);
        fprintf(fid,'%d\n'   ,Ny);
        fprintf(fid,'%d\n'   ,Nz);
        fprintf(fid,'%0.4f\n',dx);
        fprintf(fid,'%0.4f\n',dy);
        fprintf(fid,'%0.4f\n',dz);
        % launch parameter
        fprintf(fid,'%0.4f\n',xfocus);
        fprintf(fid,'%0.4f\n',yfocus);
        fprintf(fid,'%0.4f\n',zfocus);
        fprintf(fid,'%0.4f\n',ux0);
        fprintf(fid,'%0.4f\n',uy0);
        fprintf(fid,'%0.4f\n',uz0);
        fprintf(fid,'%0.4f\n',radius);
        fprintf(fid,'%0.4f\n',waist);
        % tissue optical properties
        fprintf(fid,'%d\n',2);
        for i=1:2
            fprintf(fid,'%0.4f\n',muav(i));
            fprintf(fid,'%0.4f\n',musv(i));
            fprintf(fid,'%0.4f\n',gv(i));
        end
    fclose(fid);

    filename = sprintf('%s_T.bin',myname);
    disp(['create ' filename])
    fid = fopen(filename,'wb');
    fwrite(fid,v,'uint8');
    fclose(fid);

    toc


disp('done')

