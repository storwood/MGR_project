# MGR_project


Status 31.05.2019:

The are two scripts runnable:

1. snow.sh 
example: ./snow.sh <avi_input_file>
This script overlay snow.mp4 file into inputed source. 

2. test.sh
example: ./test.sh <avi_input_file><<brightness> <blur> <noise> <resize><snow><rain_drops>


- filename - input video file
- brightnes - exposure filter. "+" symbol = overexpose, "0" symbol = no effect, "-" symbol = underexpose
- blur - enter value between <0...1> 1 = extra sharp, -1 = blury image
- noise - enter value <0,25,50,75,100>; 0 = no noise, 100 = strong noise on image
- resize - enter value between <0...1>; 0 = 0px x 0px, 1 = original size, 0.5 = size/2
- snow - enter 1 to enable snow overlap, 0 = no effect
- rain_drops - 1 to enable rain drops on lens, 0 = no effect


Action to be done:
1. Add motion blur (it is easy to do it by using ffmpeg filter before spliting video into frames)

Used ffmpeg filters:

- eq = brightness -> https://ffmpeg.org/ffmpeg-filters.html#toc-eq
- unsharp -> https://ffmpeg.org/ffmpeg-filters.html#toc-unsharp-1
- noise=alls -> https://ffmpeg.org/ffmpeg-filters.html#toc-noise
- scale=iw -> https://ffmpeg.org/ffmpeg-filters.html#toc-scale-1
