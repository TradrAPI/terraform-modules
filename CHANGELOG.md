# Changelog

## [1.21.0](https://github.com/TradrAPI/terraform-modules/compare/v1.20.0...v1.21.0) (2024-04-16)


### Features

* Add RDS iops and throughput options ([#29](https://github.com/TradrAPI/terraform-modules/issues/29)) ([2b6a29a](https://github.com/TradrAPI/terraform-modules/commit/2b6a29a08729c3842dd13502fec2f1b029f0de22))

## [1.20.0](https://github.com/TradrAPI/terraform-modules/compare/v1.19.2...v1.20.0) (2024-03-12)


### Features

* Add message to create release ([#27](https://github.com/TradrAPI/terraform-modules/issues/27)) ([a5a7724](https://github.com/TradrAPI/terraform-modules/commit/a5a772459c18efd777f7ac93aadef5f18f009ccb))

## [1.19.2](https://github.com/TradrAPI/terraform-modules/compare/v1.19.1...v1.19.2) (2024-02-26)


### Bug Fixes

* **rds:** Fix output ([29706e2](https://github.com/TradrAPI/terraform-modules/commit/29706e2941cdbe36fcd7dd96adcb0c58e8d6e790))
* Required providers version ([#25](https://github.com/TradrAPI/terraform-modules/issues/25)) ([ee07940](https://github.com/TradrAPI/terraform-modules/commit/ee079405f2ca09f4554f0a28d5e3a9f959ef85b0))

## [1.19.1](https://github.com/TradrAPI/terraform-modules/compare/v1.19.0...v1.19.1) (2024-02-26)


### Bug Fixes

* rds: include enhanced monitoring role ([#7](https://github.com/TradrAPI/terraform-modules/issues/7)) ([c8dcfae](https://github.com/TradrAPI/terraform-modules/commit/c8dcfae2b59661fbe9552383911b6ca55740ac2b))

## [1.19.0](https://github.com/TradrAPI/terraform-modules/compare/v1.18.1...v1.19.0) (2024-02-26)


### Features

* Adds cert module ([#22](https://github.com/TradrAPI/terraform-modules/issues/22)) ([6305845](https://github.com/TradrAPI/terraform-modules/commit/630584546d2c50f238e647b6b410469788a79e79))

## [1.18.1](https://github.com/TradrAPI/terraform-modules/compare/v1.18.0...v1.18.1) (2024-02-16)


### Bug Fixes

* Redis sg rule creation when sg is null ([#20](https://github.com/TradrAPI/terraform-modules/issues/20)) ([84d3183](https://github.com/TradrAPI/terraform-modules/commit/84d31833352ec2765f2b70a667cdfa1fea994334))

## [1.18.0](https://github.com/TradrAPI/terraform-modules/compare/v1.17.0...v1.18.0) (2024-01-02)


### Features

* add maximum allocated storage to rds modules ([#15](https://github.com/TradrAPI/terraform-modules/issues/15)) ([bd11021](https://github.com/TradrAPI/terraform-modules/commit/bd110216692f48bf5ac7c8d3d1b532094e9541ed))

## [1.17.0](https://github.com/TradrAPI/terraform-modules/compare/v1.16.0...v1.17.0) (2024-01-02)


### Features

* Adds release-please integration ([#12](https://github.com/TradrAPI/terraform-modules/issues/12)) ([b63a2e3](https://github.com/TradrAPI/terraform-modules/commit/b63a2e3660af6544ff3e92ab8d5020eaa64f3857))


### Bug Fixes

* Conditional check on release job ([#14](https://github.com/TradrAPI/terraform-modules/issues/14)) ([0dc3412](https://github.com/TradrAPI/terraform-modules/commit/0dc3412e832a6a8f008861a3b7db9e50ca7da5a7))

## [1.0.1](https://github.com/EAlainMG/terraform-modules/compare/v1.0.0...v1.0.1) (2023-12-26)


### Bug Fixes

* Added permission ([40f69cb](https://github.com/EAlainMG/terraform-modules/commit/40f69cb4916e20acd2d9d1003492a08a3018a72b))
* Secret ([7e5f449](https://github.com/EAlainMG/terraform-modules/commit/7e5f449d4a8694605d00ac79ef5e64cd3fcfa5d1))
* Testing versioning ([2ef430c](https://github.com/EAlainMG/terraform-modules/commit/2ef430c5413671b713d3c8d68c633e78dbf2e644))

## 1.0.0 (2023-12-26)


### Features

* add optional tgw routes ([#8](https://github.com/EAlainMG/terraform-modules/issues/8)) ([af86701](https://github.com/EAlainMG/terraform-modules/commit/af86701e563dc60d6db0768e3b546b5e17039d44))
* Add tags variable to redis ([#11](https://github.com/EAlainMG/terraform-modules/issues/11)) ([a7df8a1](https://github.com/EAlainMG/terraform-modules/commit/a7df8a12f5f8b9f2f75a47f16cf1ac2f7bd8f769))
* Release + Tagging based on conv commits ([d85a217](https://github.com/EAlainMG/terraform-modules/commit/d85a21790c6dc2c98580397a585b0819766240d8))


### Bug Fixes

* Allows redis cluster mode to be null ([6c01a1c](https://github.com/EAlainMG/terraform-modules/commit/6c01a1ce7890a8305d51a2b2a14b4a5979c02c96))
* cluster_mode ([b9336aa](https://github.com/EAlainMG/terraform-modules/commit/b9336aa887f7ba423e9a9aece36fb1bba60cd26c))
* deprecate vpc variable in eip ([3bf50ea](https://github.com/EAlainMG/terraform-modules/commit/3bf50ea96dba665b339062bc4c476b931e8fc25f))
