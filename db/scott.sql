/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : scott

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2019-04-29 13:41:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(256) DEFAULT NULL COMMENT 'url地址',
  `name` varchar(64) DEFAULT NULL COMMENT 'url描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('1', '/user', 'user:user');
INSERT INTO `t_permission` VALUES ('2', '/user/add', 'user:add');
INSERT INTO `t_permission` VALUES ('3', '/user/delete', 'user:delete');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '角色名称',
  `memo` varchar(32) DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', 'admin', '超级管理员');
INSERT INTO `t_role` VALUES ('2', 'test', '测试账户');

-- ----------------------------
-- Table structure for t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
  `rid` bigint(20) DEFAULT NULL COMMENT '角色id',
  `pid` bigint(20) DEFAULT NULL COMMENT '权限id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES ('1', '2');
INSERT INTO `t_role_permission` VALUES ('1', '3');
INSERT INTO `t_role_permission` VALUES ('2', '1');
INSERT INTO `t_role_permission` VALUES ('1', '1');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `status` char(1) NOT NULL COMMENT '是否有效 1：有效  0：锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'mrbird', '42ee25d1e43e9f57119a00d0a39e5250', '2019-04-23 11:30:41', '1');
INSERT INTO `t_user` VALUES ('2', 'test', '7a38c13ec5e9310aed731de58bbc4214', '2019-04-23 11:30:41', '1');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `rid` bigint(20) DEFAULT NULL COMMENT '角色id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('1', '1');
INSERT INTO `t_user_role` VALUES ('2', '2');
