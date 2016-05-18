%% EE564 - Design of Electrical Machines
%% Project-2: Asynchronous Traction Motor Design
%% Name: Mesut U�ur
%% ID: 1626753
%% INTRODUCTION
% In this project, we are asked to design a squirrel cage asynchronous motor
% for a high power railway traction vehicle.
%% 
% This report is composed of the following sections:
%
% # Project specifications and selected main design inputs
% # Calculation of main dimensions
% # Selection of main dimensions and validation of machine loading
% # Selection of stator slot number and turn numbers
% # Validating the results and iterations
% # Calculation of MMF, flux density, winding factors and the resultant
% induced voltage
% # Selection of rotor slot number
% # Selection of stator and rotor conductors
% # Calculation of stator slot and rotor bar dimensions
% # Calculation of equivalent core length and effective air gap distance
% # Calculation of winding and bar resistances, leakage inductances and
% magnetizing inductance
% # Calculation of copper and aluminium losses
% # Calculation of copper and aluminium masses
% # Calculation of iron mass
% # Calculation of core losses and the core loss resistance of equivalent
% circuit
% # Calculation of stator to rotor turns ratio
% # Calculation of efficiency
% # Torque-speed characteristics
% # Determination of basic parameters like starting torque, maximum torque
% etc.
% # Basic thermal analysis
% # Conclusions
% # References


%% Project Specifications
%%
% Traction asynchronous squirrel cage induction motor
%%
% Rated Power Output: 1280 kW
%%
% Line-to-line voltage: 1350 V
%%
% Number of poles: 6
%%
% Rated Speed: 1520 rpm (72 km/h) (driven with 78 Hz inverter)
%%
% Rated Motor Torque: 7843 Nm
%%
% Cooling: Forced Air Cooling
%%
% Insulating Class: 200
%%
% Train Wheel Diameter: 1210 mm
%%
% Maximum Speed: 140 km/h
%%
% Gear Ratio: 4.821


%% Main Design Inputs
%
% Duty: Continuous running duty (S1)
%%
% Efficiency: IE3, premium efficiency: 96 %
%%
% Efficiency: IE4, super premium efficiency: 97 %
%%
% The efficiency requirement is obtained by using the IE efficiency classes
% as shown in Figure below:
%%
% An efficiency of 0.95 is aimed
%%
% Power factor: 0.87
%%
% Average winding temp rise: 130 degree C
%%
% Hot spot temp rise: 160 degree C
%%
% Maximum winding temp: 200 degree C
%%
% Ingress protection: IP54. Limited protection against dust ingress.
% Protected against splash water from any direction.

I = imread('IE efficiency class.png');
figure;
imshow(I);
title('IE efficiency class','FontSize',18,'FontWeight','Bold');


%%
% Design Inputs
Prated = 1280e3; % watts
pole = 6;
pole_pair = pole/2;
phase = 3;
Vrated = 1350; % volts line-to-line
Nrated = 1520; % rpm
frated = 78; % Hz
vrated = 72; % km/h
vmax = 140; % km/h
Trated = 7843; % Nm
wheel_dia = 1.21; % m
gear_ratio = 4.821;
power_factor = 0.86; % assumed (not a given data)
efficiency = 0.965; % assumed (not a given data)


%% Main dimensions:
%%
% Machine length, inner and outer diameter, air gap distance
%%
% Electrical and magnetic loading
Vphase = Vrated/sqrt(3); % volts
Nsync = 120*frated/pole; % rpm
wrated = Nrated*2*pi/60; % rad/sec
torque = Prated/wrated; % N
power_pole_pair = Prated/pole_pair; % watts
%%
% Cmech is between 310 and 250 from graph given below. Initially,
% Cmech = 300 is chosen
I = imread('Cmec.png');
figure;
imshow(I);
title('specific Machine Constant vs Power/pole pair','FontSize',18,'FontWeight','Bold');
Cmech = 300; % kWs/m^3
fsync = 2*frated/pole; % Hz
fprintf('Synchronous speed is %g Hz(mechanical)\n',fsync);
%%
% diameter^2*length can be calculated by using the Cmec information:
d2l = Prated*1e-3/(Cmech*fsync); % m^3
%%
% The aspect ratio is calculated by using the pole number:
aspect_ratio = (pi/pole)*(pole_pair)^(1/3);
fprintf('Aspect ratio is %g\n',aspect_ratio);
%%
% From these two information, the inner diameter and length can be calculated:
inner_diameter = (d2l/aspect_ratio)^(1/3); % m
length = inner_diameter*aspect_ratio; % m
inner_radius = inner_diameter/2; % m
fprintf('Inner diameter of the machine is %g m\n',inner_diameter);
fprintf('Length of the machine is %g m\n',length);
%%
% The tangential force is calculated by using the rated torque:
Ftan = torque/inner_radius; % N
surface_area = pi*inner_diameter*length; % m^2
%%
% From the tangential force and surface area info, tangantial stress can be
% calculated:
tan_stress = 1e-3*Ftan/surface_area; % kPa
fprintf('Tangential force is %g Newtons\n',Ftan);
fprintf('Inner surface area is %g m^2\n',surface_area);
fprintf('Tangential stress is %g kPascals\n',tan_stress);
%%
% In the table below, suggested shear stress values for different kinds of
% machines are given. A value between 20 kPa and 40 kPa, (around 30 kPa)
% is acceptable. The resultant shear stress (31.5 kPa) satisfies this
% constraint.
I = imread('shear stress.png');
figure;
imshow(I);
title('Shear Stress For Different Machines','FontSize',18,'FontWeight','Bold');

%%
% For a given pole number, the empirical formula is used for outer diameter
% calculation:
outer_diameter = 1.87*inner_diameter; % for 6 pole
fprintf('Outer diameter is %g m\n',outer_diameter);
%%
% The air gap diatance calculation is alse based on the empirical formula
% given below. A scale of 1.6 is added for heavy duty operation.
% %60 increase for heavy duty
air_gap_distance = 1.6*(0.18+0.006*Prated^0.4); % mm
circumference = pi*inner_diameter; % m
fprintf('Air gap distance is %g mm\n',air_gap_distance);
fprintf('Circumference of the inner is %g m\n',circumference);
%%
% The magnetic loading of the machine is selected from the table below
% (Table 6.2 of the text book)
magnetic_loading = 0.9; % T
%%
% The electric loading is obtained from this magnetic loading and
% tangential stress information for validation.
electric_loading = sheer_stress/magnetic_loading; % kA/m
fprintf('Selected magnetic loading is %g Tesla\n',magnetic_loading);
fprintf('Resultant electric loading is %g kA/m\n',electric_loading);

I = imread('magnetic loading.png');
figure;
imshow(I);
title('Typical Magnetic Loading Values','FontSize',18,'FontWeight','Bold');

%%
% The results are validated by using the electric loading table given
% below. 34.6 kA/m electric loading is within acceptable limits.
% (Table 6.3 of the text book)

I = imread('tan stress.png');
figure;
imshow(I);
title('Typical Electric Loading Values','FontSize',18,'FontWeight','Bold');


%% Selection of main dimensions
% Choose:
inner_diameter = 0.6; % m
outer_diameter = 1.12; % m
length = 0.45; % m
air_gap_distance = 3; % mm
surface_area = pi*inner_diameter*length; % m^2
inner_volume = inner_diameter^2*length*pi/4; % m^3
circumference = pi*inner_diameter; % m
fprintf('The chosen machine dimensions are:\n\nInner diameter = %g m\n',inner_diameter);
fprintf('Outer diameter = %g m\n',outer_diameter);
fprintf('Length = %g m\n',length);
fprintf('Air gap distance = %g mm\n',air_gap_distance);
fprintf('Inner surface area = %g m^2\n',surface_area);
fprintf('Inner volume = %g m^3\n',inner_volume);
fprintf('Inner circumference = %g m\n',circumference);


%% Validation of machine loading and tangential stress
Ftan = torque/inner_radius; % N
tan_stress = Ftan/surface_area; % P
Cmech = Prated*1e-3/(inner_diameter^2*length*fsync); % kWs/m^3
magnetic_loading = 0.9; % Tesla 
electric_loading = tan_stress/magnetic_loading*1e-3; % kA/m
fprintf('The resultant tangential stress = %g kPa\n',1e-3*tan_stress);
fprintf('The resultant specific machine constant = %g kWs/m^3\n',Cmech);
fprintf('The resultant magnetic loading = %g Tesla\n',magnetic_loading);
fprintf('The resultant electrical loading = %g kA/m\n',electric_loading);


%% Selection of stator slot number and turn numbers
% Slot number selection: typical slot pitch for asynchronous motors
% is in the range of 7-45 mm. From this info, as the circumference is now
% known, the minimum and maximum number of slots can be calculated:
maximum_slot = floor(circumference/0.007);
minimum_slot = ceil(circumference/0.045);
fprintf('Minimum number of stator slots is %g\n',minimum_slot);
fprintf('Maximum number of stator slots is %g\n',maximum_slot);
%%
% We know that, the stator number of slots (Qs) should be an integer multiple of
% both phase number and pole number. Therefore, the possible stator number
% of slots can be calculated as following. The corresponding
% slot/pole/phase is also shown (qs).
integer_multiple = phase*pole;
for k = 1:10
    Qs = integer_multiple*k;
    qs = Qs/(pole*phase);
    if Qs<maximum_slot && Qs>minimum_slot 
        fprintf('%d number of stator slots is available, qs = %d\n',Qs,qs);
    end
end
%%
% Among the alternatives, the selection is based on pitch factor. It is
% aimed to eliminate the 5th harmonic by using an under-pitched stator so
% that qs should be 5. This is actually the 1st iteration of this design.
% Further iterations could be needed.
qs = 5;
Qs = qs*pole*phase;
stator_slot_pitch = circumference/Qs; % m
fprintf('Selected slot/pole/phase (qs) is %g\n',qs);
fprintf('Selected stator slot number (Qs) is %g\n',Qs);
fprintf('The resultant stator slot pitch (Tus) is %g mm. ',stator_slot_pitch*1e3);
fprintf('It is within acceptable limits.\n');
%%
% Since the harmonic elimitation will be used and the stator will be
% under-pitched, a double layer winding is needed.
stator_layer = 2;
%%
% For the elimination of 5th harmonic, a pitch factor of 4/5 or pitch angle
% of 4pi/5 will be used. The angle of one slot is also calculated.
pitch_angle = 4*pi/5; % radians electrical
slot_angle = pi/qs/phase; % radians electrical
fprintf('Pitch angle of stator is %g degrees electrical\n',pitch_angle*180/pi);
fprintf('Slot angle of stator is %g degrees electrical\n',slot_angle*180/pi);


%% Selection of flux densities (text book, page: 283) based on the table given below:
Bgap = 0.9; % T
Bsyoke = 1.6; % T
Bstooth = 1.9; % T
Bryoke = 1.6; % T
Brtooth = 2.0; % T

I = imread('magnetic loading.png');
figure;
imshow(I);
title('Suggested flux densities for different parts of the machine','FontSize',18,'FontWeight','Bold');

fprintf('All flux densities given below are peak values:\n')
fprintf('Selected air gap flux density is %g Tesla\n',Bgap);
fprintf('Selected stator back iron (yoke) flux density is %g Tesla\n',Bsyoke);
fprintf('Selected stator teeth flux density is %g Tesla\n',Bstooth);
fprintf('Selected rotor back iron (yoke) flux density is %g Tesla\n',Bryoke);
fprintf('Selected rotor teeth flux density is %g Tesla\n',Brtooth);


%% Calculation of winding factors for the particular design
% Winding factor is calculated for harmonics up to 31st as well as the
% fundamental component
n = 1:2:31; % harmonic order
kd = sin(n*qs*slot_angle/2)./(qs*sin(n*slot_angle/2)); % distribution factor
kp = sin(n*pitch_angle/2); % pitch factor
kw = kd.*kp; % winding factor
kd1 = kd(1);
kp1 = kp(1);
kw1 = kw(1);
fprintf('Distribution factor for the fundamental component is %g\n',kd1);
fprintf('Pitch factor for the fundamental component is %g\n',kp1);
fprintf('winding factor for the fundamental component is %g\n',kw1);
%%
% As expected, an attempt of elimination of harmonics and utilization of
% distributed winding configuration (high number of slots) resulted in a 10
% % loss on the fundamental component. This will yield one of the
% following:
%%
% An increase on air gap flux density: This is not desired.
%%
% An increase on the number of turns: This will result in a slightly higher
% cost and lower efficiency
%%
% An increase on the machine dimensions (pole area): This will also result
% in increase of cost and size
%%
% Let us see how will these parameters turn out to be...
%%
% The resultant distribution, pitch and winding factors for different
% frequencies are shown below.
%%
% As one can observe, the 5th harmonic is totally eliminated and the 7th
% harmonic is very low. 3rd and 9th harmonic will be eliminated
% automatically on the line-to-line voltage due to Y connection so that the
% induced EMF will be an almost harmonic free sinusoidal voltage.

figure;
subplot(3,1,1);
bar(n,kd,'k','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
ylabel('Distribution Factor','FontSize',8,'FontWeight','Bold');
set(gca,'xtick',[1:2:9]);
set(gca,'ytick',[-1:0.5:1]);
xlim([0 10]);

subplot(3,1,2);
bar(n,kp,'k','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
ylabel('Chording (Pitch) Factor','FontSize',8,'FontWeight','Bold');
set(gca,'xtick',[1:2:9]);
set(gca,'ytick',[-1:0.5:1]);
xlim([0 10]);

subplot(3,1,3);
bar(n,kw,'k','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
ylabel('Winding Factor','FontSize',8,'FontWeight','Bold');
set(gca,'xtick',[1:2:9]);
xlabel('Harmonic Order','FontSize',8,'FontWeight','Bold');
set(gca,'ytick',[-1:0.5:1]);
xlim([0 10]);


%% Selection of stator turn numbers
% In this part, the turn number selection will be based on the intended
% induced voltage (from rated voltage rating of the machine), the aimed
% flux density, the selected dimensions, calculated winding factor and the
% given rated fundamental frequency of operation.
Erms = Vphase; % volts
flux_per_pole = 4*inner_radius*length*Bgap/pole; % weber
Nph = Erms/(4.44*frated*flux_per_pole*kw1);
fprintf('The aimed induced voltage per phase is %g Volts-rms\n',Erms);
fprintf('The aimed flux per pole is %g Weber\n',flux_per_pole);
fprintf('The resultant turn number is %g\n',Nph);
%%
% Note that, number of turns per phase is calculated here. Moreover, this
% is not actually a turn number as it is not an integer value,
% it will only be used to help for the selection of actual turn number.
%%
% For the selection of number of turns, number of turns per coil side (zQ)
% is varied and alternatives are calculated as follows:
for k = 1:5
    zQ = k;
    pos_Nph = qs*pole*stator_layer*zQ/2;
    fprintf('Possible Nph = %d, zQ = %d\n',pos_Nph,k);
end
%%
% Among the alternatives, the closest turn number is 30 with zQ = 1
%%
% If 30 turns per phase is selected, either of length,radius or air gap
% flux density should be slightly increased. If 60 turns per phase is used,
% either of length, radius or air gap flux density should be decreased. In
% the first iteration, Nph = 30 is selected
Nph = 30;
zQ = 2*Nph/(qs*pole*stator_layer); % turns
fprintf('The selected turn number per phase (Nph) is %g\n',Nph);
fprintf('The resultant turn number per coil side (zQ) is %g\n',zQ);
%%
% Now, for the same amount of induced voltage, increasing the flux desity
% is not a feasible thing, so the dimensions will be increased slightly.
flux_per_pole = Erms/(4.44*frated*Nph*kw1); % weber
fprintf('The resultant flux per pole is %g Weber\n',flux_per_pole);
%%
% The old and new multiplications of radius and length are as follows:
rl_multip_old = inner_radius*length; % m^2
rl_multip = Erms*pole/(4.44*Nph*frated*kw1*4*selected_Bgap); % m^2
%%
% The length of the machine is increased accordingly. The resultant new
% machine parameters are also calculated for validation.
new_length = 0.46; % m
fprintf('New machine length is %g m\n',new_length);
new_Bgap = Erms*pole/(4.44*Nph*frated*kw1*4*new_length*inner_radius); % Tesla
new_surface_area = pi*inner_diameter*new_length; % m^2
new_inner_volume = inner_diameter^2*new_length*pi/4; % m^3
new_tan_stress = Ftan/new_surface_area; % P
new_Cmech = Prated*1e-3/(inner_diameter^2*new_length*fsync); % kWs/m^3
new_magnetic_loading = new_Bgap; % Tesla
new_electric_loading = new_tan_stress/new_magnetic_loading*1e-3; % kA/m
Bgap = new_Bgap; % Tesla
flux_per_pole = Bgap*4*inner_radius*new_length/pole; % Weber
fprintf('New air gap flux density is %g Tesla\n',Bgap);
fprintf('New surface area is %g m^2\n',new_surface_area);
fprintf('New inner volume is %g m^3\n',new_inner_volume);
fprintf('New tangential stress is %g kP\n',1e-3*new_tan_stress);
fprintf('New specific machine constant is %g kWs/m^3\n',new_Cmech);
fprintf('New magnetic loading is %g Tesla\n',new_magnetic_loading);
fprintf('New electric loading is %g kA/m\n',new_electric_loading);
fprintf('New flux per pole is %g weber\n',flux_per_pole);
%%
% The resultant induced voltage turns out to be:
Erms = 4.44*Nph*frated*kw1*flux_per_pole;
fprintf('Resultant induced voltage is %g Volts rms\n',Erms);


%% MMF Calculation
% MMF calculation is important to check whether the air gap flux density
% can be achieved with this machine geometry (air gap distance).
peak_current = Irated*sqrt(2); % amps
peak_MMF = (phase/2)*(4/pi)*(Nph*Irated*sqrt(2)/pole)*kw1; % amps
fprintf('The peak current is %g Amps\n',peak_current);
fprintf('The peak MMF is %g Amps\n',peak_MMF);
%%
% Now, the air gap flux density can be calculated from the simple magnetic
% equivalent circuit loop with length = g and H = B/u0.
u0 = 4*pi*1e-7;
Bgap_expected = F*u0/(air_gap_distance*1e-3);
fprintf('The expected peak flux density is %g Tesla with the given gap\n',Bgap_expected);
%%
% The resultant flux density is very very high! Actually, the path of the
% magnetic circuit is not only composed of the air gap (in practice, the
% cores are not infinitely permeable), moreover, the effective air gap
% distance should be considered.


%%
% stator slot current
Iu = stator_slot_pitch*electric_loading*1000; % amps



%%
% Rotor slot number

Qr = (6*qs+4)*pole_pair; % eqn 7.115 of the book
avoid_rotor_slot(Qr,Qs,pole_pair);
for k = 1:10
    Qr = k*pole*phase;
    a = avoid_rotor_slot(Qr,Qs,pole_pair);
    if a == 1
        fprintf('%d rotor slot number is usable\n',Qr);
    end
end

% In the book, 96,90,84 and 54 are suggested with one stator slot skew
% Table 7.5
Qr = 72;
qr = Qr/(pole*phase);
% harmful synchronous torque at steady state


%%
% Stator winding selection
fmax = vmax/vrated*frated; % Hz
% Normally, since the motor is to be driven by an inverter, the switching
% frequency and corresponding harmonics should be taken into account for
% skin effect. In this 1st iteration, only fundamental frequency will be
% considered.
Pin = Prated/efficiency; % watts
Irated = Pin/(sqrt(3)*Vrated*power_factor); % amps
% from awg wire table: AWG gauge starting from 000 is suitable considering
% the frequency constraint (skin effect)
% Select AWG wire gauge 000 which has a current rating of 239 amps
wire_current = 239; % amps
wire_diameter = 10.404; % mm
stator_strand = ceil(Irated/wire_current);
% three strands are required
wire_area = (wire_diameter/2)^2*pi; % mm^2
stator_current_density = Irated/wire_area; % A/mm^2
% for a 6-pole machine, J = 7.76 is in the acceptable limits

% With this current density, forced air cooling will be sufficienct


%%
% Stator slot sizing
stator_fill_factor = 0.44; % selected from the design example notes
useful_slot_area = wire_area*stator_strand*zQ*stator_layer; % mm^2
%stator_slot_area = useful_slot_area/stator_fill_factor; % mm^2
stator_stacking_factor = 0.96; % design example
Kfe = stator_stacking_factor;
Tus = stator_slot_pitch*1e3; % mm 
bts = (Bgap*Tus)/(Bstooth*Kfe); % mm

% Select the other parameters:
bos = 4; % mm
hos = 2; % mm
hw = 3; % mm

bs1 = pi*(inner_diameter*1e3+2*hos+2*hw)/Qs-bts; % mm
bs2 = sqrt(4*useful_slot_area*tan(pi/Qs)+bs1^2); % mm
hs = 2*useful_slot_area/(bs1+bs2); % mm
hcs = (1e3*outer_diameter-(1e3*inner_diameter+2*(hos+hw+hs)))/2; % mm

Bcs = flux_per_pole/(2*new_length*hcs*1e-3); % T
% The resultant yoke flux density is too low. Decrease outer diameter and
% so that decrease hcs:
Bcs_new = 1.45; % Tesla
hcs_new = flux_per_pole/(2*length*Bcs_new)*1e3; % mm
outer_diameter_new = (2*hcs_new+(1e3*inner_diameter+2*(hos+hw+hs)))*1e-3; % m

Tas = 200*atan(2*(hw-hos)/(bs1-bos))/pi; % grad


%%
% Rotor slot sizing
rotor_slot_pitch = pi*(1e3*inner_diameter-2*air_gap_distance)/Qr; % mm
Tur = rotor_slot_pitch; % mm

KI = 0.8*power_factor+0.2;
rotor_bar_current = KI*2*phase*Nph*kw1*Irated/Qr; % amps
Ib = rotor_bar_current; % amps
Jrotor = 6; % A/mm^2
Aru = Ib/Jrotor; % mm^2
Ier = Ib/(2*sin(2*pi/Qr)); % A
Jer = 0.78*Jrotor; % A/mm^2
Aer = Ier/Jer; % mm^2

btr = Bgap*Tur/(Kfe*Brtooth); % mm

% Select the other parameters:
hor = 2; % mm
bor = 4; % mm

d1 = (pi*(1e3*inner_diameter-2*air_gap_distance-2*hor)-Qr*btr)/(pi+Qr); % mm
d2 = 3; % mm
hr = (d1-d2)/(2*tan(pi/Qr)); % mm
rotor_slot_area = (pi/8)*(d1^2+d2^2)+(d1+d2)*hr/2; % mm^2
Ab = rotor_slot_area; % mm^2

hcr = 1e3*flux_per_pole/(2*length*Bryoke); % mm

Dshaftmax = inner_diameter*1e3-2*air_gap_distance-2*(hor+hr+hcr+(d1+d2)/2); % mm


%%
% Equivalent core length with cooling ducts
nv = 10; % number of cooling ducts
bv = 5; % length of cooling duct, mm
g = air_gap_distance; % mm
k = (bv/g)/(5+bv/g);
bve = k*bv; % mm
eqv_length = length-1e-3*nv*bve+1e-3*2*g; % m


%%
% Carter's factor
b1 = bs1; % mm
k = (b1/g)/(5+b1/g);
be = k*b1; % mm
kcs = Tus/(Tus-be);

k = (d1/g)/(5+d1/g);
be = k*d1; % mm
kcr = Tur/(Tur-be);

geff = g*kcs*kcr; % mm


%%
% Peak MMF
F = (phase/2)*(4/pi)*(Nph*Irated*sqrt(2)/pole)*kw1; % amps
u0 = 4*pi*1e-7;
Bgapp = F*u0/(geff*1e-3);
% ?????????


%%
% Magnetizing inductance
Lm = (phase/2)*inner_diameter*u0*eqv_length*(kw1*Nph)^2/(pole_pair^2*geff*1e-3); % Henries
Xm = 2*pi*frated*Lm; % Ohms
Imag = Vphase/Xm; % amps


%%
% Stator Leakage inductance
P1 = u0*eqv_length*((hos/bos)+(hs/(3*bs2))); % permeance
Lph = P1*4*(Nph*kw1)^2*phase/Qs; % Henries
Xph = 2*pi*frated*Lph; % ohms


%%
% Rotor Leakage inductance
Pr = 0.66 + 2*hr/(3*(d1+d2)) + hor/bor; % permeance
Pdr = 0.9*Tur/(kcs*g)*1e-2; % permeance
Kx = 1; % skin effect coefficient
P2 = u0*eqv_length*(Kx*Pr+Pdr); % permeance
Lrp = P2*4*(Nph*kw1)^2*phase/Qr; % Henries
Xrp = 2*pi*frated*Lrp; % ohms


%%
% Stator winding resistance
pole_pitch = phase*stator_slot_pitch*qs; % m
pitch_factor = pitch_angle/pi;
y = pitch_factor*pole_pitch; % m
lend = pi*y/2+0.018; % m
le = 2*(length+lend); % m
% Use copper resistivity at 80 0C
rho_20 = 1.78*1e-8; % ohm*m
rho_80 = rho_20*(1+1/273*(80-20)); % ohm*m
Rsdc = rho_80*le*Nph/(1e-6*wire_area*stator_strand); % ohms
Rsac = Rsdc; % ohms
% There is no skin effect
Rph = Rsac; % ohms


%%
% Rotor bar resistance
rho_al = 3.1*1e-8; % ohm*m
rho_al_80 = rho_al*(1+1/273*(80-20)); % ohm*m
Kr = 1.74;

Dre = inner_radius-1e-3*g; % m
b = hr+hor+(d1+d2)/2; % mm
ler = 1e-3*pi*(Dre+b)/Qr; % m

Rbe = rho_al_80*((length*Kr/(Ab*1e-6))+(ler/(2*Aer*1e-6*(sin(3*pi/Qr))^2))); %ohms
R2p = Rbe*4*phase/Qr*(Nph*kw1)^2; % ohms


%%
% Base values
Vbase = Vrated; % volts
Sbase = Prated/power_factor; % VA
Zbase = Vrated^2/Sbase; % ohms


%%
% pu values
Xm_pu = 100*Xm/Zbase; % percent
Xph_pu = 100*Xph/Zbase; % percent
Xrp_pu = 100*Xrp/Zbase; % percent
Rph_pu = 100*Rph/Zbase; % percent
R2p_pu = 100*R2p/Zbase; % percent


%%
% Copper Losses
Pcus = 3*Irated^2*Rph; % watts
Pcur = 3*Irated^2*R2p; % watts
Pcu = Pcus + Pcur; % watts


%%
% Copper mass
copper_area = (1e-6*wire_area*stator_strand); % m^2
copper_length = phase*le*Nph; % m
copper_volume = copper_area*copper_length; % m^3
copper_density = 8.96; % gr/cm^3
copper_density = copper_density*1e3; % kg/m^3
copper_mass = copper_density*copper_volume; % kg


%%
% Aluminium mass
aluminium_area1 = (1e-6*Ab); % m^2
aluminium_area2 = (1e-6*Aer); % m^2
aluminium_length1 = Qr*length; % m
aluminium_length2 = Qr*ler; % m
aluminium_volume = aluminium_area1*aluminium_length1 + aluminium_area2*aluminium_length2; % m^3
aluminium_density = 2.70; % gr/cm^3
aluminium_density = aluminium_density*1e3; % kg/m^3
aluminium_mass = aluminium_density*aluminium_volume; % kg


%% Core losses
% stator teeth weight
density_iron = 7800; % kg/m^3
Gsteeth = density_iron*Qs*bts*1e-3*(hs+hw+hos)*1e-3*length*Kfe; % kg
% stator fundamental teeth core loss
Kt = 1.7;
p10 = 2;
Pc_stator_teeth1 = Kt*p10*(frated/50)^1.3*Bstooth^1.7*Gsteeth; % watts
% stator back iron weight
Gsyoke = density_iron*pi/4*(outer_diameter_new^2-(outer_diameter_new-2*hcs*1e-3)^2)*length*Kfe; % kg
% stator fundamental back iron core loss
Ky = 1.6;
Pc_stator_yoke1 = Ky*p10*(frated/50)^1.3*Bsyoke^1.7*Gsyoke; % watts
% stator total core loss (fundamental)
Pcs1 = Pc_stator_teeth1+Pc_stator_yoke1; % watts

% rotor teeth weight
Grteeth = density_iron*Qr*btr*1e-3*(hr+(d1+d2)/2)*1e-3*length*Kfe; % kg
% stray losses
Kps = 1/(2.2-Bstooth);
Kpr = 1/(2.2-Brtooth);
Bps = (kcs-1)*Bgap; % Tesla
Bpr = (kcr-1)*Bgap; % Tesla
Piron_s = 0.5*1e-4*(Gsteeth*(Qr*frated/pole_pair*Kps*Bps)^2 + Grteeth*(Qs*frated/pole_pair*Kpr*Bpr)^2); % watts

%Pc = Pcs1 + Piron_s; % watts
Pc = Pcs1; % watts


%% Other losses
Pfw = 0.008*Prated; % watts


%% Efficiency
Ptotal = Pcu + Pc + Pfw; % watts
efficiency = Prated/(Ptotal+Prated);


%%
% ??????????
Tar = 200*atan(2*(hw-hos)/(bs1-bos))/pi; % grad

