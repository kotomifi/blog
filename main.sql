-- 创建数据库
drop database if exists my_blog;
create database my_blog DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use my_blog

-- 创建blog表
create table blog (
  blog_id  BIGINT primary key NOT NULL,
  blog_file varchar(255) NOT NULL,
  blog_date timestamp NOT NULL,
  blog_title varchar(255) NOT NULL,
  blog_author varchar(20),
  blog_abstract text NOT NULL,
  blog_modified BIGINT(13) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=2998 DEFAULT CHARSET=utf8;

-- 创建tag表
create table tag (
  tag_name varchar(20) NOT NULL,
  blog_id BIGINT NOT NULL,
  foreign key(blog_id) references blog(blog_id)
)ENGINE=InnoDB AUTO_INCREMENT=2998 DEFAULT CHARSET=utf8;

-- 创建archive表
create table archive (
  archive_name char(4) NOT NULL,
  blog_id BIGINT NOT NULL,
  foreign key(blog_id) references blog(blog_id)
)ENGINE=InnoDB AUTO_INCREMENT=2998 DEFAULT CHARSET=utf8;

