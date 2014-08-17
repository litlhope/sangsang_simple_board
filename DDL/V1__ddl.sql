CREATE TABLE `board` (
  `id` BIGINT AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `contents` VARCHAR(200),
  `reg_dt` TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ALTER TABLE `user`
--   ADD CONSTRAINT `user_uq_email` UNIQUE(`email`);