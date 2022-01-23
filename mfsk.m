function mapped = mfsk(ak ,m ,snr)
    %xronikes monades prosomoiwshs
    T_symbol = 4 * 10^(-6);
    fc = 2.5 * 10^6;
    Tc = 0.4 * 10^(-6);
    T_sample = 0.1 * 10^(-6);
    f_sample = 10^7;
    bit_rate = 1/(2*T_symbol);

    frequencies = linspace(fc,fc+m*bit_rate,m);
    quadric_pulse = sqrt(2/T_symbol);
    %time window, the duration between two samples is 1/(100*fs)
    t1=0:1/(100*f_sample):T_symbol;
    modulated = [];
    msampling = 1;

    m = log2(m);
    for i=m:m:length(ak{1})%gia ka8e m symvola
        kappa = mod(i,m)+1;
        modulated(msampling,1) = cos( pi * 2 * (frequencies(1, mod(msampling,m)+1 ) + msampling/T_symbol ) * t1(1,msampling) );
        msampling = msampling+1;
    end
    disp(modulated);
    modulated = modulated * quadric_pulse;
    
    kappa = 1;
    snr = 0;
    s2 = 1/(2*m)*(10 ^ (-snr/10) );
    my_noise = sqrt(s2)*randn( (length(ak{1})/m) ,1 );
    modulated= modulated+my_noise;
    disp(modulated);

    %%demodulation
    msampling=1;
    r = [];
    rmax = [];
    for i=1:1:length(modulated)%gia ka8e m symvola
        for j = 1:(m^2)
            r(j,1) = cos( pi * 2 * (frequencies(1, mod(j,m^2)+1 ) + msampling/T_symbol ) * t1(1,msampling) )*quadric_pulse;
        end
        rmax(msampling,1) = max(r(:,1));
        msampling = msampling+1;
    end
    disp(rmax);
end