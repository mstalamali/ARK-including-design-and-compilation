#include <opencv2/highgui.hpp>
#include <opencv2/video.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/videostab.hpp>
#include <opencv2/features2d.hpp>
#include <opencv2/stitching.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
//#include <opencv2/tracking.hpp>
//#include <opencv2/tracking/tracker.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/core/ocl.hpp>
#include <opencv2/gpu/gpu.hpp>
#include <opencv2/cudaarithm.hpp>
#include <opencv2/cudaimgproc.hpp>
#include <opencv2/cudafeatures2d.hpp>
#include <opencv2/cudawarping.hpp>


__global__

void inRange_kernel(const cv::cuda::PtrStepSz<uchar3> src, cv::cuda::PtrStepSzb dst,
                               int lbc0, int ubc0, int lbc1, int ubc1, int lbc2, int ubc2) {
  int x = blockIdx.x * blockDim.x + threadIdx.x;
  int y = blockIdx.y * blockDim.y + threadIdx.y;

  if (x >= src.cols || y >= src.rows) return;

  uchar3 v = src(y, x);
  if (v.x >= lbc0 && v.x <= ubc0 && v.y >= lbc1 && v.y <= ubc1 && v.z >= lbc2 && v.z <= ubc2)
    dst(y, x) = 255;
  else
    dst(y, x) = 0;
}

void inRange_gpu(cv::cuda::GpuMat &src, cv::Scalar &lowerb, cv::Scalar &upperb,
                 cv::cuda::GpuMat &dst) {
  const int m = 32;
  int numRows = src.rows, numCols = src.cols;
  if (numRows == 0 || numCols == 0) return;
  // Attention! Cols Vs. Rows are reversed
  const dim3 gridSize(ceil((float)numCols / m), ceil((float)numRows / m), 1);
  const dim3 blockSize(m, m, 1);

  inRange_kernel<<<gridSize, blockSize>>>(src, dst, lowerb[0], upperb[0], lowerb[1], upperb[1],
                                          lowerb[2], upperb[2]);
}
