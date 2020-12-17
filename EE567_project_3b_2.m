trials = 310000000;
occurance = 31073;
mean = occurance/trials;
variance = (((1-mean)^2)*occurance + ((0-mean)^2)*(trials-occurance))/trials;
sd = sqrt(variance);

bound1 = mean - sd/sqrt(trials)*2.576
bound2 = mean + sd/sqrt(trials)*2.576