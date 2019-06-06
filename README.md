# MGR_project


Status 06.06.2019:
All filters done
Practical part done
Next steps: Schedule demo, fixes after demo and review.

test.sh
example: ./test.sh <avi_input_file><<brightness> <blur> <noise> <resize><snow><rain_drops><motion_blur_flag><motion_blur_mode>


- filename - input video file
- brightnes - exposure filter. "+" symbol = overexpose, "0" symbol = no effect, "-" symbol = underexpose
- blur - enter value between <0...1> 1 = extra sharp, -1 = blury image
- noise - enter value <0,25,50,75,100>; 0 = no noise, 100 = strong noise on image
- resize - enter value between <0...1>; 0 = 0px x 0px, 1 = original size, 0.5 = size/2
- snow - enter 1 to enable snow overlap, 0 = no effect
- rain_drops - 1 to enable rain drops on lens, 0 = no effect
- motion_blur_flag - 1 to enable motion blur, 0 = no effect
- motion_blur_mode - as a parameter type tblend option as a string eg. average. The full list of possible options is available on ffmpeg filter documentation page: https://ffmpeg.org/ffmpeg-filters.html#Filtering-Introduction.


RESTRICTIONS:
- To use motion blur, video sequence has be to typed as an input (it won't work with images)

Used ffmpeg filters:

- eq = brightness -> https://ffmpeg.org/ffmpeg-filters.html#toc-eq
- unsharp -> https://ffmpeg.org/ffmpeg-filters.html#toc-unsharp-1
- noise=alls -> https://ffmpeg.org/ffmpeg-filters.html#toc-noise
- scale=iw -> https://ffmpeg.org/ffmpeg-filters.html#toc-scale-1
- tblend -> https://ffmpeg.org/ffmpeg-all.html#blend_002c-tblend
