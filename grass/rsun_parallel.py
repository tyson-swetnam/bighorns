#!/usr/bin/env python

from copy import deepcopy
from grass.pygrass.modules import Module, ParallelModuleQueue

def main(elevation):
    # compute slope and aspect for r.sun
    Module('r.slope.aspect', elevation=elevation, aspect='aspect', slope='slope', overwrite=True)
    # initialize an empty queue and list
    queue = ParallelModuleQueue(nprocs=16)
    sun_name = 'sun_day{}_t{}'
    # set computational region
    Module('g.region', raster=elevation)
    # initialize a module instance with shared inputs
    for t in range(5,20):
        for d in range(1,366):
            print(d)
            sun = Module('r.sun.mp', elevation=elevation, slope='slope', aspect='aspect',
                         glob_rad='glob', time=t, step=1, day=d, threads=16, run_=False, overwrite=True)
                # create a copy of the module and set the remaining parameters
                
            m = deepcopy(sun)(glob_rad=sun_name.format(d,t), time=t)
            queue.put(m)
        queue.wait()
    Module('r.gdal.out', createopt="COMPRESS=LZW", input=[sun_name.format(d,t) for t in range(5, 20)], 
           output='/mnt/tyson_swetnam/Data/goldwater/[sun_name.format(d,t) for t in range(5, 20)]', format='Gtiff', overwrite=True)
    # set color table
    Module('r.colors', map=[sun_name.format(d,t) for t in range(5, 20)], color='grey', flags='e')
if __name__ == '__main__':
    elevation = 'dem'
    main(elevation)
