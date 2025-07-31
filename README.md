# Openlane Flow for the FABulUSB controller

This repository contains the configuration for the Openlane 2 flow for the
[FABulUSB controller](https://github.com/IAmMarcelJung/fabulous_usb/tree/main/controller).

## Contents

- `config.json`: Configuration for the OpenLane 2 flow.
- `clocks.sdc`: Constraint file for the two clocks used.
- `ip`: Empty directory where a the external code will be put.

## Instructions

The setup is based on [this example](https://github.com/mole99/ihp-openlane-examples) by Leo Moser.

To update the controller code, simply run `make update-controller`.
