import numpy as np
import matplotlib.pyplot as plt

dt = 0.01
tfinal = 100
v0 = 0
v1 = 1
v3 = 3
DT = 0.22
DR = 0.16

t = np.arange(dt, tfinal, dt)
x = np.loadtxt("abp_msd_final_heun_2d_0.txt")
x1 = np.loadtxt("abp_msd_final_heun_2d_1.txt")
#x2 = np.loadtxt("abp_msd_final_heun_2d_2.txt")
x3 = np.loadtxt("abp_msd_final_heun_2d_3.txt")
msd_analytical_0 = (4*DT + (2*v0**2)/DR)*t + ((2*v0**2)/DR**2)*(np.exp(-DR*t) - 1)
msd_analytical_1 = (4*DT + (2*v1**2)/DR)*t + \
    ((2*v1**2)/DR**2)*(np.exp(-DR*t) - 1)
msd_analytical_3 = (4*DT + (2*v3**2)/DR)*t + \
    ((2*v3**2)/DR**2)*(np.exp(-DR*t) - 1)


plt.figure()
plt.title("MSD of an ABP in 2-D")
plt.plot(x[:, 0], x[:, 1], 'blue', linewidth=6, alpha=0.5)
plt.plot(x1[:, 0], x1[:, 1], 'red', linewidth=6, alpha=0.5)
plt.plot(x3[:, 0], x3[:, 1], 'orange', linewidth=6, alpha=0.5)

#plt.plot(x1[:, 0], x1[:, 1], 'k')
#plt.plot(x1[:, 0], x1[:, 1], 'k')
plt.plot(t, msd_analytical_0, 'k')
plt.plot(t, msd_analytical_1, 'k')
plt.plot(t, msd_analytical_3, 'k')
plt.xlim(0.01, 100)
plt.legend(["Velocity = 0(Numerical)",
            "Velocity = 1(Numerical)", "Velocity = 3(Numerical)", "Black line = Analytical"])
plt.xscale("log")
plt.yscale("log")
plt.xlabel("Time")
plt.ylabel("MSD")
plt.show()
