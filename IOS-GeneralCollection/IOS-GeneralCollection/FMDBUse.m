//
//  FMDBUse.m
//  IOS-GeneralCollection
//
//  Created by apple on 18/9/9.
//  Copyright © 2018年 LuXing. All rights reserved.
//

#import "FMDBUse.h"
#import "FMDB.h"



@interface FMDBUse ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation FMDBUse




/******1、导入依赖库libsqlit3.0.tbd*********/


/******2、导入FMDB库****************/


/*******3、使用**********/


/*****字段说明

主键：primary key。主键的值必须唯一，用于标识每一条记录，如学生的学号；主键同时也是一个索引，通过主键查找记录速度较快；主键如果是整数类型，该列的值可以自动增长；

自增：autoincrement

非空：Not Null。字段值不能为空，否则报错。

唯一：Unique。约束此字段值唯一。主键默认唯一。

条件检查：Check。该字段值必须符合条件才能存入。

默认值：Default。
 
*****/




//创建数据库
- (void)creatDB{
    
    //1.获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",docPath);
    
    
    //设置数据库名称
    NSString *fileName = [docPath stringByAppendingPathComponent:@"数据库名称.sqlite"];
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:fileName];
    if ([_db open]) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"打开数据库失败");
    }

}


//创建表
- (void)createTable{
    
    
    //3.创建表
    BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student(表名称) (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
}


//插入数据
- (void)insertData{
    
    NSString *name,*sex;
    NSInteger age;
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    BOOL result1 = [_db executeUpdate:@"INSERT INTO t_student(表名) (name, age, sex) VALUES (?,?,?)",name,@(age),sex];
    //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
    BOOL result2 = [_db executeUpdateWithFormat:@"insert into t_student(表名) (name,age, sex) values (%@,%i,%@)",name,age,sex];
    //3.参数是数组的使用方式
    BOOL result3 = [_db executeUpdate:@"INSERT INTO t_student(表名)(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
    if (result1) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}



//更新数据
- (void)updateData{
    //修改学生的名字
    NSString *newName = @"李浩宇";
    NSString *oldName = @"王子涵2";
    BOOL result = [_db executeUpdate:@"update t_student set name = ? where name = ?",newName,oldName];
    if (result) {
        NSLog(@"修改成功");
    } else {
        NSLog(@"修改失败");
    }
}


//删除数据
- (void)delelteData{
    //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
    int idNum = 11;
    BOOL result = [_db executeUpdate:@"delete from t_student where id = ?",@(idNum)];
    //2.不确定的参数用%@，%d等来占位
    //BOOL result = [_db executeUpdateWithFormat:@"delete from t_student where name = %@",@"王子涵"];
    if (result) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}



//查询数据
- (void)queryData{
    //查询整个表
    FMResultSet * resultSet = [_db executeQuery:@"select * from t_student"];
    //根据条件查询
    //FMResultSet * resultSet = [_db executeQuery:@"select * from t_student where id < ?", @(4)];
    //遍历结果集合
    while ([resultSet next]) {
        int idNum = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet objectForColumnName:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSString *sex = [resultSet objectForColumnName:@"sex"];
        NSLog(@"学号：%@ 姓名：%@ 年龄：%@ 性别：%@",@(idNum),name,@(age),sex);
    }
}


//表的删除
- (void)deleteTable{
    //如果表格存在 则销毁
    BOOL result = [_db executeUpdate:@"drop table if exists t_student"];
    if (result) {
        NSLog(@"删除表成功");
    } else {
        NSLog(@"删除表失败");
    }
}


//关闭数据库
- (void)closeDB{
    BOOL result = [_db close];
    if(result){
        NSLog(@"数据库关闭成功");
    }
    else {
        NSLog(@"数据库关闭失败");
    }
}



@end
