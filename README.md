# Relion external crYOLO job support

These scripts can be called inside the [Relion](https://relion.readthedocs.io) user interface in the **External** jobs section. They setup a correct Relion directory structure and call the external [crYOLO](https://cryolo.readthedocs.io) particle picking software using the crYOLO generic model. This means no handpicking or training a model is required. The picked coordinates can be imported with the Relion **Import** function. Instructions to view and verify the picks in Relion are provided in the user guide mentioned below.

These scripts have been tested with *Relion 3.1* and *4.0beta* and *crYOLO 1.6* up to *1.8*.

## Known limitations

 * Only the pre-made crYOLO **gmodel** can be used so far
 * Only the additional **threshold** parameter can be set and changed in the Relion user interface
 * All *MRC* files in Relion are organized in a **Movies** or **Micrographs** folder. The user guide provides examples how to link movies from a complex EPU folder into this structure.

## Installation

It is assumed that the Relion and crYOLO software is already installed and the crYOLO gmodel files are downloaded from the original site.

1. Checkout the repository or download the bash scripts

2. Decide if you run the scripts *locally* on a workstation or *submit* the crYOLO job as a job to a computing cluster. A working example from our SLURM cluster is provided. 

3. **Adapt** and **add** the settings from **env.source** file to your environment (e.g. **$HOME/.bashrc**). Alternatively you can **adapt** and **copy** the file **env.modules** to e.g. **$HOME/privatemodules/relion-ext-cryolo** if you are using *environment modules*.

4. *(Optional)* The scripts run just with the environment settings. You can override the crYOLO calls in these *cryolo_gmodel.sh* scripts if needed.

5. Put the bash script **relion_ext_cryolo_gmodel.sh** to **$PATH** like **/usr/local/bin** or choose it via the **Browse** button in Relion.

6. (Optional) You can set your own pre-trained model instead the *gmodel* files in the according environment variables.

## User guide

A simple user guide can be found on [Relion crYOLO integration](https://confluence.desy.de/display/CCS/Relion+crYOLO+integration).


