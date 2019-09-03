#!/bin/python3

"""
Addapted from http://keatonb.github.io/archivers/shanimate (by keatonb).

This script generates spherical harmonic animations as gifs as well as a static plot of the "common"
view of spherical harmonic (namely, $Re(Y)^2$, colored using the value of $Re(Y)$)
"""

#import stuff
from __future__ import division, print_function
import sys
import argparse
import scipy.special as sp
import numpy as np
import cartopy.crs as ccrs
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib import animation
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm, colors

# pierre-24: trick since I get a very odd (and old) error
from matplotlib.axes import Axes
from cartopy.mpl.geoaxes import GeoAxes
GeoAxes._pcolormesh_patched = Axes.pcolormesh

def plot_sh_on_sphere(ell, m, args):
    #ensure valid input
    assert np.abs(m) <= ell
    assert np.abs(args.inc) <= 180

    outfile = args.outfile 
    if outfile is None:
        outfile = 'l{0}m{1}_ss{2}.gif'.format(ell,m, '_s' if args.square else '')
    
    plotcrs = ccrs.Orthographic(0, 90-args.inc)

    #compute spherical harmonic
    lon = np.linspace(0,2*np.pi,args.nlon)-np.pi
    lat = np.linspace(-np.pi/2,np.pi/2,args.nlat)
    colat = lat+np.pi/2
    d = np.zeros((len(lon),len(colat)),dtype = np.complex64)
    for j, yy in enumerate(colat):
        for i, xx in enumerate(lon):
            d[i,j] = sp.sph_harm(m,ell,xx,yy)
    
    # set up figure
    fig = plt.figure(figsize=(args.size,args.size), tight_layout = {'pad': 1})
    ax = plt.subplot(projection=plotcrs)
    
    if args.square:
        d = abs(d)
        
    vlim = np.max(np.real(d))
    
    # Animate:
    def animate(i):
        drm = np.transpose(np.real(d*np.exp(-1.j*(2.*np.pi*float(i) / 
                                                  np.float(args.nframes)))))
        sys.stdout.write("\rFrame {0} of {1}".format(i+1,args.nframes))
        sys.stdout.flush()
        ax.clear()
        ax.pcolormesh(lon*180/np.pi,lat*180/np.pi,drm,
             transform=ccrs.PlateCarree(),cmap='seismic',vmin=-vlim,vmax=vlim,shading='flat')
        ax.relim()
        ax.autoscale_view()
        
    def init():
        animate(0)
    
    if m != 0 and not args.square:
        interval = args.duration / np.float(args.nframes)
          
        anim = animation.FuncAnimation(fig, animate, init_func=init, 
                                       frames=args.nframes, interval=interval, 
                                       blit=False)
        anim.save(outfile, dpi=args.dpi, fps = 1./interval, writer='imagemagick')

        print('\nWrote '+outfile)
        
    else: # no need for an animation for those parameters
        animate(0)
        fig.savefig(outfile.replace('gif', 'png'), dpi=args.dpi)

        print('\nWrote '+outfile.replace('gif', 'png'))

def plot_sh_in_spherical_coos(ell, m, args):
    # inspired by http://balbuceosastropy.blogspot.com/2015/06/spherical-harmonics-in-python.html
    
    #ensure valid input
    assert np.abs(m) <= ell

    outfile = args.outfile 
    if outfile is None:
        outfile = 'l{0}m{1}_sp{2}.png'.format(ell,m, '_s' if args.square else '')
    
    PHI, THETA = np.mgrid[0:2*np.pi:200j, 0:np.pi:100j]
    R = sp.sph_harm(m, ell, PHI, THETA)
    
    if args.square:
        R = abs(R)
        RS = R
    else:
        R = R.real
        RS = R**2
    
    # Convert to cartesian coordinates for the 3D representation
    X = RS * np.sin(THETA) * np.cos(PHI)
    Y = RS * np.sin(THETA) * np.sin(PHI)
    Z = RS * np.cos(THETA)
    
    fig = plt.figure(figsize=(1.2*args.size, args.size), tight_layout = {'pad': 0})
    ax = fig.add_subplot(projection='3d')
    ax.axis('off')
    
    norm = colors.Normalize()
    
    im = ax.plot_surface(X, Y, Z, rstride=1, cstride=1, facecolors=cm.bwr(norm(R)))
    m = cm.ScalarMappable(cmap=cm.bwr)
    m.set_array(R)
    fig.savefig(outfile, dpi=args.dpi)

    print('\nWrote '+outfile)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
            description = 'Generate animated gif of spherical harmonic.')
    parser.add_argument('ell', type=int, help='spherical degree')
    parser.add_argument('m', type=int, help='azimuthal order')
    parser.add_argument('-o','--outfile', type=str, 
                        help='output gif filename')
    parser.add_argument('-i','--inc', type=float, default=60, 
                        help='inclination (degrees from pole)')
    parser.add_argument('-s','--size', type=float, default=1, 
                        help='image size (inches)')
    parser.add_argument('-n','--nframes', type=int, default=32, 
                        help='number of frames in animation')
    parser.add_argument('-d','--duration', type=float, default=2, 
                        help='animation duration (seconds)')
    parser.add_argument('--nlon', type=int, default=200, 
                        help='number of longitude samples')
    parser.add_argument('--nlat', type=int, default=500, 
                        help='number of latitude samples')
    parser.add_argument('--dpi', type=float, default=300, 
                        help='dots per inch')
    parser.add_argument('-S', '--square', action='store_true', 
                        help='plot the square')
    args = parser.parse_args()
    
    plot_sh_on_sphere(args.ell, args.m, args)
    plot_sh_in_spherical_coos(args.ell, args.m, args)

