
function samples = ms2samples(time,fs)

if time == 0
    samples = 1;
else
    samples = (time/1000)*fs;
end

end