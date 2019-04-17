# Cropping vs. Masking

The two raster functions we probably use most often are the `crop()` function and the `mask()` function. From an intuitive perspective, both of these functions involve putting in a "larger" raster and getting out something "smaller" -- so what is the difference? Is there a difference?? (As you've probably guessed, given the existence of this Markdown, the answer to that second question is yes).

## Cropping

The documentation for the `crop()` function describes it as "return[ing] a geographic subset of an object as specified by an Extent object." In less technical terms, cropping cuts a `raster` down to a smaller region. You can think of the `crop()` function a lot like cropping a photo: it takes something that used to cover a larger area and trims it down to a smaller rectangle. In raster terms, cropping changes the *extent* of the raster, i.e. the area it covers. When we are trying to create a raster for a given bounding box, we can just crop it (without masking) so that the raster will take on the shape of the smaller rectangle (bounding box) that we provide. Also, keep in mind that cropping a raster will not change any of the values in the raster.

## Masking

Masking, however, changes raster values, but not raster extents. When you mask raster A by raster B, all the cells in raster A that have NA values in the mask (raster B) are changed to `NA` (or another value you can specify with the argument `updatevalue`). The extent of the raster, or the area it covers, does not change, however. In keeping with the photo analogy, masking is analogous to removing the background of a photo -- the resulting image is the same size, but it now only has certain pixels with non-NA values.

## Compare and contrast

|                              |  `crop()`   |  `mask()` |
|------------------------------|-------------|-----------|
| What would it do to a photo? | rectangle   | anything  |
| What does it do to a raster? | rectangle   | anything  |
| Resulting shape?             | rectangle   | anything  |
| Change extent?               | yes         | no        |
| Change cell values?          | no          | yes       |
| Resulting shape?             | rectangle   | anything  |

## Other options

### Masking options

If you want to change the values in the raster to something other than `NA`, you can change the `updatevalue` argument in the `mask()` function: then all cells that are `NA` in the mask raster (raster B) will be set to `updatevalue` in raster A.

If you set `inverse = TRUE` in the `mask()` function, you can set the cells that are *not* `NA` in the mask (raster B) to `NA` in the original raster (raster A), instead of vice versa.

### `extend()`

