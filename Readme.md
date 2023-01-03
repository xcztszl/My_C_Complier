## 我的简单的C语言编译器

#### 项目结构：

![1672686222390](image/Readme/1672686222390.png)



本项目完成了一个基本的C语言编译器，目前阶段主要完成了以下功能：

**功能实现：**

* [X] 词法分析
* [X] 语法分析&构建语法树
  * [X] 支持函数调用
* [X] 类型检查
* [X] 中间代码生成
* [X] 目标代码生成
  * [X] 生成MIPS汇编指令
  * [X] 目标代码可使用MARS运行



#### 运行方式

* 首先配置系统的环境变量，将flex文件夹下的bin目录的绝对路径添加进系统Path的环境变量，确保flex和bison指令可以正常执行
* 进入program文件夹内打开终端，或者使用vscode直接将program添加进工作区，在终端内输入 run [带后缀的文件名],此时将会自动对[带后缀的文件名]的文件进行分析(.c后缀)

**一个例子**

`run test1.c`


#### 项目分工





#### 项目内容






#### 运行结果




#### 感悟与总结

吕正202083260078：本次实验负责类型检查部分。首先是处理布尔表达式，关键是关系运算表达式的处理，两个操作数都按照基本表达式进行处理。其次处理基本表达式，若传入正确的标识符，查符号表，获得位置；若传入错误的标识符就进行提示，比如未定义的变量，类型不匹配，数组维数非整型，维度越界，维度超过定义值等；若传入整型，为整型常量生成一个临时变量并检查；浮点型和字符型同整型；然后检查赋值语句是否有左值，检查赋值语句的运算左右是否匹配，检查右值是否是一个变量或临时变量，检查++和--，是否有左值，并检查++或--作用的是否是整型等。通过不断查阅资料和修改，增强了手写和调试代码的能力，也加深了对编译器的认识。不过也有一些不足之处，比如按照算术表达式的方式来计算布尔值没有完成，部分类型属性计算没有考虑到错误处理等情况。



#### 参考连接：

参考了bison文件的编写框架 https://github.com/gamesgao/ComplierForSmallC/blob/master/Simple.y

参考部分项目结构与部分中间代码生成 https://github.com/ICE99125/c_compiler/blob/main/README.md

参考了部分语法分析树的构建过程 https://blog.csdn.net/hello_tomorrow_111/article/details/78745868?spm=1001.2101.3001.6650.18&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-18-78745868-blog-20483209.pc_relevant_aa&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-18-78745868-blog-20483209.pc_relevant_aa&utm_relevant_index=19

参考了部分parser.c的内容并转化使用进了parser.y https://download.csdn.net/download/downk/16347479?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-download-2%7Edefault%7ECTRLIST%7EPaid-1-16347479-blog-78745868.pc_relevant_3mothn_strategy_and_data_recovery&depth_1-utm_source=distribute.pc_relevant_t0.none-task-download-2%7Edefault%7ECTRLIST%7EPaid-1-16347479-blog-78745868.pc_relevant_3mothn_strategy_and_data_recovery&utm_relevant_index=1

参考部分flex编写内容 https://github.com/gamesgao/ComplierForSmallC/blob/master/Simple.lex


学习博客：

① https://blog.csdn.net/wp1603710463/article/details/50365495

② https://shiyi.blog.csdn.net/article/details/52988428?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-52988428-blog-126979975.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-52988428-blog-126979975.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=3

③ https://blog.csdn.net/weixin_44007632/article/details/108666375

④ https://youyuyuyou.blog.csdn.net/article/details/78895327?spm=1001.2101.3001.6650.3&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-3-78895327-blog-126979975.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-3-78895327-blog-126979975.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=4

⑤ https://blog.csdn.net/Rosa_zz/article/details/54880256?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522167250214816800211563954%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=167250214816800211563954&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduend~default-1-54880256-null-null.142^v68^control,201^v4^add_ask,213^v2^t3_control1&utm_term=lex%E4%BD%BF%E7%94%A8

⑥ https://blog.csdn.net/qq_36411874/article/details/83000350 Bison使用说明

⑦* https://blog.csdn.net/pandaxcl/article/details/1321552 系列[Lex和Yacc从入门到精通](https://blog.csdn.net/pandaxcl/article/details/1321552)1~6
