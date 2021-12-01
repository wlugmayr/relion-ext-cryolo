# Relion external job integration with the crYOLO particle picking software

These scripts have been tested with Relion 3.1 and 4.0beta and crYOLO 1.6 up to 1.8.

## Known limitations

 * only the crYOLO **gmodel** can be used so far
 * only the **threshold** parameter can be set in the Relion user interface


## Installation

It is assumed that the Relion and crYOLO software is already installed and the crYOLO gmodel files are downloaded from the original site.

1. Checkout the repository or download the bash scripts

2. Adapt and add the settings from **env.source** file to your environment (e.g. **$HOME/.bashrc**)

3. Put the bash script **relion_ext_cryolo_gmodel.sh** to **$PATH** like **/usr/local/bin** or choose it via the **Browse** button in Relion.


## User guide

A simple user guide can be found on [Relion crYOLO integration](https://confluence.desy.de/display/CCS/Relion+3.1+crYOLO+integration).


