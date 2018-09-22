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
    如果ID设置为逐渐，且设置为自动增长的话，那么把表中的数据删除后，重新插入新的数据，ID的编号不是从0开始，而是接着之前的ID进行编号。

非空：Not Null。字段值不能为空，否则报错。

唯一：Unique。约束此字段值唯一。主键默认唯一。

条件检查：Check。该字段值必须符合条件才能存入。

默认值：Default。
 
 
 
 
 SQL语法
 1.注释
 /注释多行/
 注释单行
 2.不区分大小写
 3.每条语句后必须加分号
 4.字符串使用单引号括起来
 5.字段类型：text->字符串类型 integer->整型 real->浮点型
 
 
 
 
 
 
 模糊查询
 //注意%为转义字符
 NSString *sql = [NSString stringWithFormat:@"SELECT * FROM BookDBModel WHERE BookName LIKE '%%%@%%'",@"我"];

 
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
    
    
    //3.创建表        -- CREATE TABLE IF NOT EXISTS t_Student(id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer DEFAULT 18,studyId integer UNIQUE);

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
    //修改学生的名字   -- 将表中'小明1'的年龄变成18
                 // -- UPDATE t_Student SET age=18 WHERE name='小明1';
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

/***
 
 
 
 - 格式1: SELECT 字段名1,字段名,... FROM 表名;   ->查询指定的字段
 -- SELECT name,score FROM t_Student;
 
 
 
 -- 格式2: SELECT * FROM 表名;  ->查询表中所有的字段
 -- SELECT * FROM t_Student;
 -- 获取表中年龄大于20，分数小于60的学生的所有信息
 -- SELECT * FROM t_Student WHERE age>20 AND score<60;
 
 
 -- 2.获取表中的数据的个数
 -- 格式1:SELECT count(*) FROM 表名;
 -- SELECT count(*) FROM t_Student;
 -- 计算表中不及格的学生的数量
 -- SELECT count(*) FROM t_Student WHERE score<60;
 
 
 -- 3.对查询结果进行排序
 -- 格式：SELECT * FROM 表名 ORDER BY 字段名
 -- SELECT * FROM t_Student ORDER BY score;  -- 将查询结果按照分数从小到大排序
 -- SELECT * FROM t_Student ORDER BY score desc; -- 将查询结果按照分数从大到小排序
 
 -- 4.限制查询的结果的数量
 -- 格式: SELECT * FROM 表名 LIMIT 数值1,数值2;   -- 数值1->从0开始数第几条数据开始获取；数值2->一次获取数据的数量
 -- SELECT * FROM t_Student LIMIT 1,5;
 
 */


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





//事务处理
- (void)handleTransaction:(NSString *)sender {
    
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test1.db"];
    FMDatabase *db = [[FMDatabase alloc]initWithPath:dbPath];
    [db open];
    if (![db isOpen]) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text1 (name text,age,integer,ID integer)"];
    if (result) {
        NSLog(@"create table success");
    }
    //1.开启事务
    [db beginTransaction];
    NSDate *begin = [NSDate date];
    BOOL rollBack = NO;
    @try {
        //2.在事务中执行任务
        for (int i = 0; i< 500; i++) {
            NSString *name = [NSString stringWithFormat:@"text_%d",i];
            NSInteger age = i;
            NSInteger ID = i *1000;
            
            BOOL result = [db executeUpdate:@"insert into text1(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
            if (result) {
                NSLog(@"在事务中insert success");
            }
        }
    }
    @catch(NSException *exception) {
        //3.在事务中执行任务失败，退回开启事务之前的状态
        rollBack = YES;
        [db rollback];
    }
    @finally {
        //4. 在事务中执行任务成功之后
        rollBack = NO;
        [db commit];
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"在事务中执行插入任务 所需要的时间 = %f",time);
    
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
