# Changelog


## [4.0.1](https://github.com/TradrAPI/terraform-modules/compare/v4.0.0...v4.0.1) (2025-05-01)


### Bug Fixes

* **kafka_plugins:** Handles empty alias cases ([cd66156](https://github.com/TradrAPI/terraform-modules/commit/cd661564dbae3757e83eedb416d98cfdf1e7c4ff))

## [4.0.0](https://github.com/TradrAPI/terraform-modules/compare/v3.4.0...v4.0.0) (2025-05-01)


### ⚠ BREAKING CHANGES

* **kafka:** Rremove kafka backup from the base module ([#130](https://github.com/TradrAPI/terraform-modules/issues/130))

### Features

* **kafka:** Rremove kafka backup from the base module ([#130](https://github.com/TradrAPI/terraform-modules/issues/130)) ([1f27b7a](https://github.com/TradrAPI/terraform-modules/commit/1f27b7a2a04c262ecbb48eb4b64fb2a8c6017daf))

## [3.4.0](https://github.com/TradrAPI/terraform-modules/compare/v3.3.1...v3.4.0) (2025-05-01)


### Features

* **kafka:** Split backup from main module ([b9dc0b3](https://github.com/TradrAPI/terraform-modules/commit/b9dc0b3f3ff468cc0dff1faee2003809cabf502e))


### Refactor

* **kafka:** Moves backup code to dedicated module ([#128](https://github.com/TradrAPI/terraform-modules/issues/128)) ([c46510d](https://github.com/TradrAPI/terraform-modules/commit/c46510d264c0f65fa50f32c463267f726d6493ff))

## [3.3.1](https://github.com/TradrAPI/terraform-modules/compare/v3.3.0...v3.3.1) (2025-05-01)


### Bug Fixes

* **kafka,kafka_plugins,s3:** Warnings over s3 bucket deprecations ([15e65a7](https://github.com/TradrAPI/terraform-modules/commit/15e65a7e00a0710c960f8a1a1edf82db61443fb1))

## [3.3.0](https://github.com/TradrAPI/terraform-modules/compare/v3.2.2...v3.3.0) (2025-05-01)


### Features


* **turbo_repo_remote_cache:** Add conditional rule to create lambda function ([db4d6c4](https://github.com/funderpro/terraform-modules/commit/db4d6c4343f49e0a005eefd3943364bfd7d757ea))
* **turbo_repo_remote_cache:** Add conditional rule to create lambda function ([b3e3656](https://github.com/funderpro/terraform-modules/commit/b3e3656e5b8065d4a9d87040169433c01359840e))
* **turbo_repo_remote_cache:** Add conditional rule to create lambda function ([0ade0bf](https://github.com/funderpro/terraform-modules/commit/0ade0bfc5e25f99754b43318db81455db97f4374))
* **turbo_repo_remote_cache:** Add conditional rule to create lambda function ([c3b246f](https://github.com/funderpro/terraform-modules/commit/c3b246fa2c73f4fd1abe860a222edd4789b25720))
* **turbo_repo_remote_cache:** Add conditional rule to create lambda function ([59d92cb](https://github.com/funderpro/terraform-modules/commit/59d92cbf0a43d2436fab29d756af64d17dca0d35))
* **turbo_repo_remote_cache:** Add conditional rule to create lambda function ([2cb6113](https://github.com/funderpro/terraform-modules/commit/2cb611383bfabd1431619b6410d793dd35a5ed02))

* **core:** Update list of changelog sections triggering a release PR ([95ba3ea](https://github.com/TradrAPI/terraform-modules/commit/95ba3eae67aa5688554875c47eeea97a8eccdfef))


### Refactor

* **kafka:** Split plugins setup to a separate module ([#125](https://github.com/TradrAPI/terraform-modules/issues/125)) ([062dfdf](https://github.com/TradrAPI/terraform-modules/commit/062dfdff3381463d016db115d399ab987f00db0d))


## [3.2.2](https://github.com/TradrAPI/terraform-modules/compare/v3.2.1...v3.2.2) (2025-03-14)


### Bug Fixes

* **mongodbatlas/user:** Password resolution logic ([#123](https://github.com/TradrAPI/terraform-modules/issues/123)) ([5ab2ac1](https://github.com/TradrAPI/terraform-modules/commit/5ab2ac1ddf43d25438991e58cbe248c256cee1e0))

## [3.2.1](https://github.com/TradrAPI/terraform-modules/compare/v3.2.0...v3.2.1) (2025-02-24)


### Bug Fixes

* **turbo_repo_remote_cache:** Misssing npm run build ([bb81a71](https://github.com/TradrAPI/terraform-modules/commit/bb81a71598be1adc06fa8eb4ce8eca18a78ac428))

## [3.2.0](https://github.com/TradrAPI/terraform-modules/compare/v3.1.0...v3.2.0) (2025-02-24)


### Features

* **turbo_repo_remote_cache:** Upgrade the turbo-remote-cache version ([#120](https://github.com/TradrAPI/terraform-modules/issues/120)) ([dc723a0](https://github.com/TradrAPI/terraform-modules/commit/dc723a069455eb23dbaba4f636a32d59e7be6299))

## [3.1.0](https://github.com/TradrAPI/terraform-modules/compare/v3.0.0...v3.1.0) (2025-02-04)


### Features

* **network:** Allows overriding flowlog role and policy names ([#118](https://github.com/TradrAPI/terraform-modules/issues/118)) ([f4145c3](https://github.com/TradrAPI/terraform-modules/commit/f4145c3ee1e1125a64283b9ce6a36aa24e7ef6a9))

## [3.0.0](https://github.com/TradrAPI/terraform-modules/compare/v2.1.2...v3.0.0) (2025-02-03)


### ⚠ BREAKING CHANGES

* **network:** Turns v2 routes the default ([#116](https://github.com/TradrAPI/terraform-modules/issues/116))

### Features

* **network:** Turns v2 routes the default ([#116](https://github.com/TradrAPI/terraform-modules/issues/116)) ([ede1b3b](https://github.com/TradrAPI/terraform-modules/commit/ede1b3b7d8c9575eb5e195b422334aec59b96739))

## [2.1.2](https://github.com/TradrAPI/terraform-modules/compare/v2.1.1...v2.1.2) (2025-02-03)


### Bug Fixes

* **aws:** Add retention to vpc flowlogs ([#114](https://github.com/TradrAPI/terraform-modules/issues/114)) ([612eb3a](https://github.com/TradrAPI/terraform-modules/commit/612eb3aad2f9a093e4a0bae4565dde1a0e52b484))

## [2.1.1](https://github.com/TradrAPI/terraform-modules/compare/v2.1.0...v2.1.1) (2025-01-27)


### Bug Fixes

* **aws:** Add vpc network flowlogs ([#112](https://github.com/TradrAPI/terraform-modules/issues/112)) ([3f67498](https://github.com/TradrAPI/terraform-modules/commit/3f6749874f7d8292d227263db0957dbeb63cc089))

## [2.1.0](https://github.com/TradrAPI/terraform-modules/compare/v2.0.0...v2.1.0) (2025-01-23)


### Features

* Added std-ec2 tf module codes ([#110](https://github.com/TradrAPI/terraform-modules/issues/110)) ([e866739](https://github.com/TradrAPI/terraform-modules/commit/e8667394cbc4f0713f40f98f0159a9920f351ed3))

## [2.0.0](https://github.com/TradrAPI/terraform-modules/compare/v1.41.2...v2.0.0) (2025-01-16)


### ⚠ BREAKING CHANGES

* **redis:** Updated redis module ([#107](https://github.com/TradrAPI/terraform-modules/issues/107))

### Features

* **redis:** Updated redis module ([#107](https://github.com/TradrAPI/terraform-modules/issues/107)) ([7a3d98d](https://github.com/TradrAPI/terraform-modules/commit/7a3d98d71470c4779e9b05e1a5d838b0c67198fb))

## [1.41.2](https://github.com/TradrAPI/terraform-modules/compare/v1.41.1...v1.41.2) (2025-01-15)


### Bug Fixes

* **redis:** Updated module ([#105](https://github.com/TradrAPI/terraform-modules/issues/105)) ([05a564d](https://github.com/TradrAPI/terraform-modules/commit/05a564db5113041744b3c07aeab72292ce61f86a))

## [1.41.1](https://github.com/TradrAPI/terraform-modules/compare/v1.41.0...v1.41.1) (2025-01-07)


### Bug Fixes

* **turbo_remote_cache:** Adds missing parameters ([f5401be](https://github.com/TradrAPI/terraform-modules/commit/f5401be5e6e68ab18f0afaf1931d75c90d1752ac))

## [1.41.0](https://github.com/TradrAPI/terraform-modules/compare/v1.40.0...v1.41.0) (2024-12-26)


### Features

* **kafka:** Deletes backed up messages after 14days ([#102](https://github.com/TradrAPI/terraform-modules/issues/102)) ([4c684c2](https://github.com/TradrAPI/terraform-modules/commit/4c684c2f40d5885ee36ffc8ce947da5ed32b31be))

## [1.40.0](https://github.com/TradrAPI/terraform-modules/compare/v1.39.0...v1.40.0) (2024-12-26)


### Features

* **kafka:** Allows configuring partitions size ([#100](https://github.com/TradrAPI/terraform-modules/issues/100)) ([b1e66ca](https://github.com/TradrAPI/terraform-modules/commit/b1e66ca3fd63408716814a4d1d7eb0b8cea7db9b))

## [1.39.0](https://github.com/TradrAPI/terraform-modules/compare/v1.38.0...v1.39.0) (2024-12-09)


### Features

* **kafka:** Add amazon-s3-sing-connector-url ([#98](https://github.com/TradrAPI/terraform-modules/issues/98)) ([0a85ca8](https://github.com/TradrAPI/terraform-modules/commit/0a85ca8589dbbb5ff1142c7e4db0404de7c1802d))

## [1.38.0](https://github.com/TradrAPI/terraform-modules/compare/v1.37.0...v1.38.0) (2024-11-15)


### Features

* **ec2:** Add name to ec2 outputs ([131e3c8](https://github.com/TradrAPI/terraform-modules/commit/131e3c87f0ad66d63f460f80b48a7018ee9054bc))

## [1.37.0](https://github.com/TradrAPI/terraform-modules/compare/v1.36.0...v1.37.0) (2024-11-12)


### Features

* **ebs:** Add defaults ebs to ec2 module ([#95](https://github.com/TradrAPI/terraform-modules/issues/95)) ([b98b313](https://github.com/TradrAPI/terraform-modules/commit/b98b3131035a5f8a6afa0d14d4c859c89cc90d55))

## [1.36.0](https://github.com/TradrAPI/terraform-modules/compare/v1.35.0...v1.36.0) (2024-10-21)


### Features

* **ec2:** Adding IOPS option for ebs ([#94](https://github.com/TradrAPI/terraform-modules/issues/94)) ([c06c66e](https://github.com/TradrAPI/terraform-modules/commit/c06c66e65949cf7aa2a904b991401436380b3a6c))


### Bug Fixes

* **ec2:** Setting iops variable to default null ([#92](https://github.com/TradrAPI/terraform-modules/issues/92)) ([4c8c9f7](https://github.com/TradrAPI/terraform-modules/commit/4c8c9f7a3ae0597dd12bf4c724d916bacde3052d))

## [1.35.0](https://github.com/TradrAPI/terraform-modules/compare/v1.34.4...v1.35.0) (2024-10-17)


### Features

* **ec2:** Adds iops options to ec2 ([#90](https://github.com/TradrAPI/terraform-modules/issues/90)) ([4c4c614](https://github.com/TradrAPI/terraform-modules/commit/4c4c614d51629d8937266c2958f59c3bf26ae6a6))

## [1.34.4](https://github.com/TradrAPI/terraform-modules/compare/v1.34.3...v1.34.4) (2024-09-10)


### Bug Fixes

* Random password module ([#86](https://github.com/TradrAPI/terraform-modules/issues/86)) ([4947dc7](https://github.com/TradrAPI/terraform-modules/commit/4947dc7cefbcc1d2831b32e4705ac2e8cc99cf50))

## [1.34.3](https://github.com/TradrAPI/terraform-modules/compare/v1.34.2...v1.34.3) (2024-09-09)


### Bug Fixes

* **mongodb:** Resolve undetermined count issue in random_password ([#84](https://github.com/TradrAPI/terraform-modules/issues/84)) ([d6a4688](https://github.com/TradrAPI/terraform-modules/commit/d6a468860d42353232b9264793a1db81d8cb5b66))

## [1.34.2](https://github.com/TradrAPI/terraform-modules/compare/v1.34.1...v1.34.2) (2024-09-09)


### Bug Fixes

* **mongodb:** Resolve undetermined count issue in random_password resource ([#82](https://github.com/TradrAPI/terraform-modules/issues/82)) ([e3c582f](https://github.com/TradrAPI/terraform-modules/commit/e3c582fcbe308ed93b0c58cf066f4e51225fd950))

## [1.34.1](https://github.com/TradrAPI/terraform-modules/compare/v1.34.0...v1.34.1) (2024-08-15)


### Bug Fixes

* Replace deprecated value with content in cert module ([#80](https://github.com/TradrAPI/terraform-modules/issues/80)) ([78a9d3a](https://github.com/TradrAPI/terraform-modules/commit/78a9d3a1f7cd6777ef8676796c86754a99ce6f08))

## [1.34.0](https://github.com/TradrAPI/terraform-modules/compare/v1.33.4...v1.34.0) (2024-07-17)


### Features

* Add kafka module ([#75](https://github.com/TradrAPI/terraform-modules/issues/75)) ([d32d99b](https://github.com/TradrAPI/terraform-modules/commit/d32d99b8e493f0bd209d411e5bea8e6c12e92447))

## [1.33.4](https://github.com/TradrAPI/terraform-modules/compare/v1.33.3...v1.33.4) (2024-07-15)


### Bug Fixes

* **network:** Add unique values on concat lists to aboid errors ([#76](https://github.com/TradrAPI/terraform-modules/issues/76)) ([dacb873](https://github.com/TradrAPI/terraform-modules/commit/dacb873ba87126237293a15d1405d64a27360fe0))

## [1.33.3](https://github.com/TradrAPI/terraform-modules/compare/v1.33.2...v1.33.3) (2024-07-03)


### Bug Fixes

* Release please missing files ([#73](https://github.com/TradrAPI/terraform-modules/issues/73)) ([0970e36](https://github.com/TradrAPI/terraform-modules/commit/0970e369e45931732db4841ef724daae72e2e54b))

## [1.33.2](https://github.com/TradrAPI/terraform-modules/compare/v1.33.1...v1.33.2) (2024-06-20)


### Bug Fixes

* Allows customizing ec2 group description ([#71](https://github.com/TradrAPI/terraform-modules/issues/71)) ([65a4e1a](https://github.com/TradrAPI/terraform-modules/commit/65a4e1a23b769bf26cca1f15a5ea9bb54eae4a3f))

## [1.33.1](https://github.com/TradrAPI/terraform-modules/compare/v1.33.0...v1.33.1) (2024-06-19)


### Bug Fixes

* Adds required providers to s3 module ([#68](https://github.com/TradrAPI/terraform-modules/issues/68)) ([02daf44](https://github.com/TradrAPI/terraform-modules/commit/02daf445072840c02dc0e31a8034cc6a6d93589f))
* delete replica feature ([#69](https://github.com/TradrAPI/terraform-modules/issues/69)) ([cdff632](https://github.com/TradrAPI/terraform-modules/commit/cdff632a59d47de46520a07ae535331477a40040))

## [1.33.0](https://github.com/TradrAPI/terraform-modules/compare/v1.32.1...v1.33.0) (2024-06-19)


### Features

* Turbo remote cache timeout ([#64](https://github.com/TradrAPI/terraform-modules/issues/64)) ([dad3fd0](https://github.com/TradrAPI/terraform-modules/commit/dad3fd058d15d2e20c80719d0db1bc815af97d05))

## [1.32.1](https://github.com/TradrAPI/terraform-modules/compare/v1.32.0...v1.32.1) (2024-06-14)


### Bug Fixes

* Rds read replica ([#65](https://github.com/TradrAPI/terraform-modules/issues/65)) ([2b830cd](https://github.com/TradrAPI/terraform-modules/commit/2b830cd3dd8e74a9fd0c07c0100af0fc44865157))

## [1.32.0](https://github.com/TradrAPI/terraform-modules/compare/v1.31.0...v1.32.0) (2024-06-12)


### Features

* **ci:** Add new replicate_source_db variable to enable read replica creation. ([#62](https://github.com/TradrAPI/terraform-modules/issues/62)) ([4442c7a](https://github.com/TradrAPI/terraform-modules/commit/4442c7a3143ed75ab9aed6c979d3282b1b0c5e57))

## [1.31.0](https://github.com/TradrAPI/terraform-modules/compare/v1.30.1...v1.31.0) (2024-06-06)


### Features

* Adds module for turbo repo remote cache deploy as lambda function ([#60](https://github.com/TradrAPI/terraform-modules/issues/60)) ([ce5f244](https://github.com/TradrAPI/terraform-modules/commit/ce5f2444689db3963027f7a37f46ea0905d14f97))

## [1.30.1](https://github.com/TradrAPI/terraform-modules/compare/v1.30.0...v1.30.1) (2024-06-04)


### Bug Fixes

* add required_provider on secret module ([#58](https://github.com/TradrAPI/terraform-modules/issues/58)) ([871d28d](https://github.com/TradrAPI/terraform-modules/commit/871d28d9abc8600ee6b2d0c108ed1c101ecfff73))

## [1.30.0](https://github.com/TradrAPI/terraform-modules/compare/v1.29.1...v1.30.0) (2024-06-03)


### Features

* Add secrets replication on the secrets module ([#56](https://github.com/TradrAPI/terraform-modules/issues/56)) ([5ead9b4](https://github.com/TradrAPI/terraform-modules/commit/5ead9b4ff8d9ac7364d6bfba53aa3f01e38c5b7a))

## [1.29.1](https://github.com/TradrAPI/terraform-modules/compare/v1.29.0...v1.29.1) (2024-05-29)


### Bug Fixes

* Adds missing required providers to ec2 module ([#52](https://github.com/TradrAPI/terraform-modules/issues/52)) ([b209ab2](https://github.com/TradrAPI/terraform-modules/commit/b209ab226e244d6b3eebdc93c4744cfcf5467b28))

## [1.29.0](https://github.com/TradrAPI/terraform-modules/compare/v1.28.1...v1.29.0) (2024-05-24)


### Features

* add secret module ([#50](https://github.com/TradrAPI/terraform-modules/issues/50)) ([cfc6d23](https://github.com/TradrAPI/terraform-modules/commit/cfc6d23807ca3392f291ec149e425b194d8841a9))

## [1.28.1](https://github.com/TradrAPI/terraform-modules/compare/v1.28.0...v1.28.1) (2024-05-22)


### Bug Fixes

* Update kms module ([#46](https://github.com/TradrAPI/terraform-modules/issues/46)) ([7621a6b](https://github.com/TradrAPI/terraform-modules/commit/7621a6b9f6af695b399a4a3974522b4796bb1c12))
* Uses null defaults for iops and storage_throughput ([#47](https://github.com/TradrAPI/terraform-modules/issues/47)) ([8e85a3b](https://github.com/TradrAPI/terraform-modules/commit/8e85a3b2849ab45a86b53b150234e84e1d5835ed))

## [1.28.0](https://github.com/TradrAPI/terraform-modules/compare/v1.27.0...v1.28.0) (2024-05-22)


### Features

* Adding new Variable to EC2 module ([#43](https://github.com/TradrAPI/terraform-modules/issues/43)) ([3244891](https://github.com/TradrAPI/terraform-modules/commit/32448919f0c9851a6dcc4d58d99f03d8dd249833))

## [1.27.0](https://github.com/TradrAPI/terraform-modules/compare/v1.26.0...v1.27.0) (2024-05-16)


### Features

* Allows customizing VPC and subnets cidrs ([#41](https://github.com/TradrAPI/terraform-modules/issues/41)) ([5af8c77](https://github.com/TradrAPI/terraform-modules/commit/5af8c77420c825c8627951f22fecf1895547d98e))

## [1.26.0](https://github.com/TradrAPI/terraform-modules/compare/v1.25.0...v1.26.0) (2024-04-29)


### Features

* Adds conventional PR check ([0ca51dc](https://github.com/TradrAPI/terraform-modules/commit/0ca51dcbe3ae56216467d004d97e2ceca1810b45))


### Bug Fixes

* Routes setup for code still using the other routes method ([#39](https://github.com/TradrAPI/terraform-modules/issues/39)) ([dbf21f7](https://github.com/TradrAPI/terraform-modules/commit/dbf21f7aafe51e157f670aec10f5e62fe98ebee0))

## [1.25.0](https://github.com/TradrAPI/terraform-modules/compare/v1.24.0...v1.25.0) (2024-04-26)


### Features

* Makes perf insights configurable ([#37](https://github.com/TradrAPI/terraform-modules/issues/37)) ([d5b896e](https://github.com/TradrAPI/terraform-modules/commit/d5b896ecdb0fbb39c143e9a46b5800e4f68af01e))

## [1.24.0](https://github.com/TradrAPI/terraform-modules/compare/v1.23.0...v1.24.0) (2024-04-26)


### Features

* Prevent tgw subnet creation if no cidr is passed ([#35](https://github.com/TradrAPI/terraform-modules/issues/35)) ([97b77f3](https://github.com/TradrAPI/terraform-modules/commit/97b77f3d2fc4b130deccc9d5fda97f725be05d61))

## [1.23.0](https://github.com/TradrAPI/terraform-modules/compare/v1.22.0...v1.23.0) (2024-04-25)


### Features

* Adds TGW support to the network module ([#33](https://github.com/TradrAPI/terraform-modules/issues/33)) ([9751e33](https://github.com/TradrAPI/terraform-modules/commit/9751e3352b2cfd208b13785f9a40897bdf6a370d))

## [1.22.0](https://github.com/TradrAPI/terraform-modules/compare/v1.21.0...v1.22.0) (2024-04-22)


### Features

* Add storage encryption toggle to RDS module ([#31](https://github.com/TradrAPI/terraform-modules/issues/31)) ([fdf58e5](https://github.com/TradrAPI/terraform-modules/commit/fdf58e5c1b6d193597394d775dabfc7bf225ccfe))

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
