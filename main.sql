-- 创建数据库
drop database if exists xiah_blog;
create database xiah_blog DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use xiah_blog

-- 创建blog表
create table blog (
  blog_id  int(12) primary key NOT NULL,
  blog_file varchar(255) NOT NULL,
  blog_date timestamp NOT NULL,
  blog_title varchar(255) NOT NULL,
  blog_author varchar(20),
  blog_abstract text NOT NULL
);

-- 创建tag表
create table tag (
  tag_name varchar(20) primary key NOT NULL,
  blog_id int(12) NOT NULL,
  foreign key(blog_id) references blog(blog_id)
);

-- 创建archive表
create table archive (
  archive_name char(4) primary key NOT NULL,
  blog_id int(12) NOT NULL,
  foreign key(blog_id) references blog(blog_id)
);
