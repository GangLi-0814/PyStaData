# 高级数据过滤

主要内容：介绍如何用 `AND` 和 `OR` 操作符组合成 `WHERE` 子句，还讲授了如何明确地管理求值顺序，如何使用 `IN` 和 `NOT` 操作符。

## 组合 WHERE 子句

`AND` 操作符：

```SQL
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' AND prod_price <= 4;
```

`OR` 操作符：

```SQL
SELECT prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
```

`AND` 和 `OR` 结合进行复杂、高级的过滤：

```SQL
SELECT prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
    AND prod_price >= 10;
```

注意：**SQL（像多数语言一样）在处理 `OR` 操作符前，优先处理 `AND` 操作符**。当 SQL 看到上述 `WHERE` 子句时，它理解为：由供应商 BRS01 制造的价格为 10 美元以上的所有产品，以及由供应商 DLL01 制造的所有产品，而不管其价格如何。所以要注意操作符组合的求值顺序。

要选取供应商 DLL01 或 BRS01 制造的且价格在 10 美元及以上的所有产品该如何实现？可以通过圆括号对操作符分组：

```SQL
SELECT prod_name, price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
    AND prod_price >= 10;
```

这是因为圆括号具有比 `AND` 和 `OR` 更高的求值顺序。任何时候使用具有 `AND` 和 `OR` 操作符的 `WHERE` 子句时，最好都使用圆括号以消除歧义。

## `IN` 操作符

`IN` 操作符以指定条件范围，`IN` 取一组由逗号分隔、括在圆括号中的合法值。

```SQL
SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN ('DLL01', 'BRS01'）
ORDER BY prod_name;
```

上面的操作等价于使用 `OR` 的效果，即：

```SQL
SELECT prod_name, prod_id
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
ORDER BY prod_name;
```

使用 `IN` 的优势如下：

- 在有很多合法选项时，`IN` 操作符的语法更清楚，更直观。
- 在与其他 `AND` 和 `OR` 操作符组合使用 `IN` 时，求值顺序更容易管理。
- `IN` 操作符一般比一组 `OR` 操作符执行得更快（在上面这个合法选项很少的例子中，还看不出性能差异）。
- `IN` 的最大优点是可以包含其他 SELECT 语句，能够更动态地建立 `WHERE` 子句。

## `NOT` 操作符

`WHERE` 中的 `NOT` 操作符只有一个功能：否定**其后**所跟的任何条件。比如列出除 DLL01 之外的所有供应商的产品，可写为：

```SQL
SELECT prod_name
FROM Products
WHERE NOT vend_id == 'DLL01'
ORDER BY prod_name
```

也可以采用操作符写成：

```SQL
SELECT prod_name
FROM Products
WHERE vend_id <> 'DLL01'
ORDER BY prod_name
```

`IN` 的优势：对于这里的这种简单的 WHERE 子句，使用 NOT 确实没有什么优势。但在更复杂的子句中，NOT 是非常有用的。例如，在与 IN 操作符联合使用时，NOT 可以非常简单地找出与条件列表不匹配的行。

# 用通配符进行过滤

主要内容：介绍什么是通配符、如何使用通配符以及怎样使用 LIKE 操作符进行通配搜索，以便对数据进行复杂过滤。

## `LIKE` 操作符

当过滤中使用的值是未知的（模糊的），用简单的比较操作符肯定不行，必须使用通配符。**利用通配符，可以创建比较特定数据的搜索模式**。

- 通配符(wildcard)：用来匹配值的一部分的特殊字符。通配符搜索只能用于文本字段（字符串），非文本数据类型字段不能使用通配符搜索。
- 搜索模式(search pattern)：由字面值、通配符或两者组合构成的搜索条件。

为在搜索子句中使用通配符，必须使用 `LIKE` 操作符。`LIKE` 指示 DBMS ，**后跟的搜索模式利用通配符匹配而不是简单的相等匹配进行比较**。

## 通配符一览

|   通配符   |                               用途                               |
| :--------: | :--------------------------------------------------------------: |
| 百分号(%)  |                     表示任何字符出现任意次数                     |
| 下划线(\_) | 下划线的用途与 `%` 一样，但它只匹配**单个字符**，而不是多个字符  |
| 方括号([]) | 用来指定一个字符集，它必须匹配指定位置（通配符的位置）的一个字符 |

### 百分号(%)通配符

为了找出所有以词 Fish 起头的产品：

```SQL
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%';
```

也可以使用多个通配符：

```SQL
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%;

```

也可以出现在搜索模式的中间。比如要找出以 F 起头、以 y 结尾的所有产品：

```SQL
SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y%';
````

注意：
1. 如果使用 Microsoft Access，需要使用 `*` 而不是 `%`。
2. 根据 DBMS 的不同及其配置，搜索可以是区分大小写的。
3. 除了能匹配一个或多个字符外，`%` 还能匹配 0 个字符。`%` 代表搜索模式中给定位置的 0 个、1 个或多个字符。
4. 注意文本后面的空格，使用通配符之前先使用函数去除文本空格。
5. 通配符 `%`不会匹配 NULL 行。

### 下划线(\_)通配符

```SQL
SELECT prod_id, prod_name
FROM Products
# __ 表示匹配 2 位
WHERE prod_name LIKE '__ inch teddy bear';

/*Output:
prod_id prod_name
-------- --------------------
BR02 12 inch teddy bear
BR03 18 inch teddy bear
*/
```

匹配所有字符：

```SQL
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '% inch teddy bear';

/*Output:
prod_id prod_name
-------- --------------------
BR01 8 inch teddy bear
BR02 12 inch teddy bear
BNR3 18 inch teddy bear
*/
```

注意:如果使用的是 Microsoft Access，需要使用 `?` 而不是 `_` 。

### 方括号([])通配符

找出所有名字以 J 和 M 起头的联系人：

```SQL
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[JM]%'
ORDER BY cust_contact;
```

解释：[JM] 匹配方括号中任意一个字符，但它只能匹配单个字符。因此，任何多于一个字符的名字都不匹配。[JM] 之后的 % 通配符匹配第一个字符之后的任意数目的字符，返回所需结果。

可以用前缀字符 `^`（脱字号）来否定，查询相反的条件，比如要查询除了 J 和 M 之外的任意字符起头的联系人：

```SQL
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[^JM]%'
ORDER BY cust_contact;
```

注意：如果使用的是 Microsoft Access，需要用 `!` 而不是 `^` 来否定一个集合，因此，使用的是 `[!JM]` 而不是 `[^JM]` 。

上例也可以使用 `NOT` 操作符得到类似的结果：

```SQL
SELECT cust_contact
FROM Customers
WHERE NOT cust_contact LIKE '[JM]%'
ORDER BY cust_contact;
```

## 使用通配符的技巧

**SQL 的通配符很有用，但这种功能是有代价的，即通配符搜索一般比前面讨论的其他搜索要耗费更长的处理时间**。这里给出一些使用通配符时要记住的技巧：

- 不要过度使用通配符。如果其他操作符能达到相同的目的，应该使用其他操作符。
- 在确实需要使用通配符时，也尽量不要把它们用在搜索模式的开始处。把通配符置于开始处，搜索起来是最慢的。
- 仔细注意通配符的位置。如果放错地方，可能不会返回想要的数据。

# 创建计算字段

主要内容：介绍什么是计算字段，如何创建计算字段，以及如何从应用程序中使用别名引用它们。

## 计算字段

存储在数据库表中的数据一般不是应用程序所需要的格式。比如，需要显示公司名，同时还需要显示公司的地址，但这两个信息存储在不同的表列中。所以**需要直接从数据库中检索出转换、计算或格式化过的数据，而不是检索出数据，然后再在客户端应用程序中重新格式化**。与前面介绍的列不同，**计算字段并不实际存在于数据库表中，计算字段是运行时在 `SELECT` 语句内创建的**。

## 拼接字段

### 需求

Vendors 表包含供应商名和地址信息。假如要生成一个供应商报表，需要在格式化的名称（位置）中列出供应商的位置。此报表需要一个值，而表中数据存储在两个列 vend_name 和 vend_country 中。此外，需要用括号将 vend_country 括起来，这些东西都没有存储在数据库表中。这个返回供应商名称和地址的 `SELECT` 语句很简单，但我们是如何创建这个组合值的呢？

### 思路

解决办法是把两个列拼接起来。在 SQL 中的 `SELECT` 语句中，可使用一个特殊的操作符来拼接两个列。根据你所使用的 DBMS ，此操作符可用加号（+）或两个竖杠（||）表示。Access 和 SQL Server 使用 `+` 号。DB2、Oracle、PostgreSQL、SQLite 和 Open Office Base 使用 `||` 。在 MySQL 和 MariaDB 中，必须使用特殊的函数。

### 实现过程

使用加号：

```SQL
SELECT vend_name + ' (' + vend_country + ')' -- 注意空格填充
FROM Vendors
ORDER BY vend_name;

/*Output:
----------------------------
Bear Emporium (USA )
Bears R Us (USA )
Doll House Inc. (USA )
Fun and Games (England )
Furball Inc. (USA )
Jouets et ours (France )
*/
```

使用 `||`：

```SQL
SELECT vend_name || ' (' || vend_country || ')'
FROM Vendors
ORDER BY vend_name;

/*Output:
----------------------------
Bear Emporium (USA )
Bears R Us (USA )
Doll House Inc. (USA )
Fun and Games (England )
Furball Inc. (USA )
Jouets et ours (France )
*/
```

使用 MySQL 或 MariaDB :

```SQL
SELECT Concat(vend_name, ' (', vend_country, ')')
FROM Vendors
ORDER BY vend_name;
```

注意：再看看上述 `SELECT` 语句返回的输出。结合成一个计算字段的两个列用空格填充。许多数据库（不是所有）保存填充为列宽的文本值，而实际上你要的结果不需要这些空格。为正确返回格式化的数据，必须去掉这些空格。这可以使用 SQL 的 `RTRIM()` 函数来完成，如下所示：

```SQL
# 加号写法
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
FROM Vendors
ORDER BY vend_name;

# || 写法
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
FROM Vendors
ORDER BY vend_name;

/*Output：
-------------------------------
Bear Emporium (USA)
Bears R Us (USA)
Doll House Inc. (USA)
Fun and Games (England)
Furball Inc. (USA)
Jouets et ours (France)
*/
```

上面的例子只是拼接字段进行输出，但是它没有名字，只是显示值。但是未命名的列不能用于客户端应用中，因为客户端没有办法引用它。所以我们需要使用别名（也被称为导出列（derived column）），别名（alias）是一个字段或值的替换名。别名用 AS 关键字赋予。写法如下：

```SQL
# 加号
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
    AS vend_title
FROM Vendors
ORDER BY vend_name;

# || 语法
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
    AS vend_title
FROM Vendors
ORDER BY vend_name;

# MySQL 和 MariaDB 语句
SELECT Concat(vend_name, ' (', vend_country, ')')
    AS vend_title
FROM Vendors
ORDER BY vend_name;

/*Output:
vend_title
----------------------------
Bear Emporium (USA)
Bears R Us (USA)
Doll House Inc. (USA)
Fun and Games (England)
Furball Inc. (USA)
Jouets et ours (France)
*/
```

## 执行算术计算

计算字段的另一常见用途是对检索出的数据进行算术计算。比如 Orders 表包含收到的所有订单，OrderItems 表包含每个订单中的各项物品。

首先检索订单号 2008 中的所有物品：

```SQL
SELECT prod_id, quantity, item_price
FROM OrderItems
WHERE order_num = 2008;

/*Output:
prod_id quantity item_price
---------- ----------- ---------------------
RGAN01 5 4.9900
BR03 5 11.9900
BNBG01 10 3.4900
BNBG02 10 3.4900
BNBG03 10 3.4900
*/
```

汇总物品的价格（单价乘以订购数量）：

```SQL
SELECT prod_id,
       quantity,
	   item_price,
	   quantity*item_price AS expanded_price
FROM OrderItems
WHERE order_num = 2008;

/*Output:
prod_id quantity item_price expanded_price
---------- ----------- ------------ -----------------
RGAN01 5 4.9900 24.9500
BR03 5 11.9900 59.9500
BNBG01 10 3.4900 34.9000
BNBG02 10 3.4900 34.9000
BNBG03 10 3.4900 34.9000
*/
```

提示：**`SELECT` 语句为测试、检验函数和计算提供了很好的方法**。虽然 `SELECT` 通常用于从表中检索数据，但是省略了 `FROM` 子句后就是简单地访问和处理表达式，例如 `SELECT 3 * 2;` 将返回 6 ，`SELECT Trim(' abc ');` 将返回 abc ，`SELECT Now();` 使用 `Now()` 函数返回当前日期和时间。
