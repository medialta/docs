# sqlGetFromDca

The `sqlGetFromDca` hook is triggered when sql definitions in DCA files are evaluated. It passes
the generated SQL definition and expects the same as return value.

> #### primary:: Available   
> from Contao 3.2.0.



## Parameters

1. *array* `$arrSql`

    The parsed SQL definition.



## Return Values

Return `$arrSql` after adding your custom definitions.


## Example

```php
<?php

// config.php
$GLOBALS['TL_HOOKS']['sqlGetFromDca'][] = array('MyClass', 'mySqlGetFromDca');

// MyClass.php
public function mySqlGetFromDca($arrSql)
{
    // Modify the array of SQL statements

    return $arrSql;
}
```


## More information


### References

- [system/modules/core/library/Contao/Database/Installer.php](https://github.com/contao/core/blob/3.5.0/system/modules/core/library/Contao/Database/Installer.php#L310-L317)


### See also

- [sqlCompileCommands](sqlCompileCommands.md) – triggered when compiling the database update commands.
- [sqlGetFromDB](sqlGetFromDB.md) – triggered when parsing the current database definition.
- [sqlGetFromFile](sqlGetFromFile.md) – triggered when parsing database.sql files.
