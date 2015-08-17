#' Make a usearea file
#'
#' Make a usearea file for image compositing
#' @param dir character. full path name to scene directory example: "E:/mss/wrs2/038029"
#' @param outfile charcter. full path of output file
#' @param xmx numeric.max x coordinate
#' @param xmn numeric.min x coordinate
#' @param ymx numeric.max y coordinate
#' @param ymn numeric.min y coordinate
#' @import raster
#' @export

make_usearea_file = function(dir, outfile, xmx, xmn, ymx, ymn){
  projfiles = list.files(path = file.path(dir[1], "images"), pattern="proj.txt", full.names=T, recursive=T)
  if(length(projfiles) == 0){projfiles = list.files(path = file.path(dir[2], "images"), pattern="proj.txt", full.names=T, recursive=T)}
  if(length(projfiles) == 0){projfiles = list.files(path = file.path(dir[3], "images"), pattern="proj.txt", full.names=T, recursive=T)} 
  if(length(projfiles) == 0){projfiles = list.files(path = file.path(dir[4], "images"), pattern="proj.txt", full.names=T, recursive=T)} 
  
   
  crs = readLines(projfiles[1])
  res = 30
  r = raster(xmn=xmn, xmx=xmx, ymn=ymn, ymx=ymx, crs=crs, res=res)
  r[] = 1
  r = as(r, "SpatialGridDataFrame")       
  writeGDAL(r, outfile, drivername = "GTiff", options="INTERLEAVE=BAND", type = "Byte", mvFlag = 0)
}


