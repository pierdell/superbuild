#include <sqlite3.h>
#include <iostream>
#include <eigen3/Eigen/Core>
#include <sophus/se3.hpp>
#include <basalt/spline/se3_spline.h>

int main(int argc, char **argv)
{
    typedef Sophus::SE3<double> SE3d;
    SE3d se3;

    basalt::Se3Spline<3> spline(50000);
    spline.genRandomTrajectory(100);

    se3.setQuaternion(Eigen::Quaterniond(1, 0, 0, 0));
    std::cout << "Matrix:\n"
              << se3.matrix() << std::endl;
    std::cout << "[Passing Build + Run Test]: Ok" << std::endl;
    return 0;
}