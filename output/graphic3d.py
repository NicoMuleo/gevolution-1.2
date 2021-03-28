# -*- coding: utf-8 -*-
"""
Created on Wed Jan 22 10:36:49 2020

@author: nicom
"""
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np

import h5py




#phi0h5= h5py.File('..\Result29\output_sds50\lcdm_snap004_phi.h5', 'r')
phi0h5= h5py.File('lcdm_snap003_phi.h5', 'r')




ls = list(phi0h5.keys())
print(ls)

phi0=phi0h5.get('data')

print(phi0.shape[0])



fig = plt.figure()
ax = fig.gca(projection='3d')



X = np.arange(0, phi0.shape[1], 1)
Y = np.arange(0, phi0.shape[1], 1)
X, Y = np.meshgrid(X, Y)
Z = phi0[32]


# Plot the surface.
surf = ax.plot_surface(X, Y, Z, cmap=cm.coolwarm,
                       linewidth=0, antialiased=False)

#surf = ax.plot_wireframe(X, Y, Z, cmap=cm.coolwarm,
 #                      linewidth=0, antialiased=False)

# Customize the z axis.
#ax.set_zlim(0.95, 1.01)
ax.zaxis.set_major_locator(LinearLocator(10))
ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

# Add a color bar which maps values to colors.
#fig.colorbar(surf, shrink=0.5, aspect=5)
plt.title("Present time Matter Density($\Omega_k=0.03$)\n half box section")
plt.show()
