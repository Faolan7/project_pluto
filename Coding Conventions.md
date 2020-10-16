# Naming Conventions
## Capitalization
**Constant Variables:** `CAPITAL_CASE`<br>
**General Variables:** `snake_case`<br>
**Functions:** `snake_case`<br>
**Class Names:** `PascalCase`


# Layout Conventions
## Comments
Single-line comments occur on their own line directly above the code they refer to. In the case that the comment is explaining obscure code, it may occur at the end of the line.<br>
Multi-line comments have their starting and ending sequences directly above and below the comment on their own lines.
<br><br>
Comments are written in proper English, but do not include a terminating period or contractions.

```Python
# This is a single-line comment
obscure code # This is a comment explaining obscure code

'''
This is an example of
a multi-line comment
'''
```

Note that in GDScript, `'''` actually denotes a multi-line string. This syntax can be used a multi-line comment within functions, but cannot be used outside of a function.

## Brace Placement
When defining a non-functional block, the opening brace occurs at the end of the definition line, and the closing brace occurs on its own line immediately after the final line of code.
<br><br>
In GDScript, this exclusively applies to initializing collections. Discretion should be used when deciding how many items to put on a single line.

```
var array = [
    ...
]
```

## Spacing
**Sections:** Two blank lines occur immediately after a code section.<br>
**Functions:** A single blank line occurs immediately after a function.<br>
**Binary Operators:** A single space occurs between a binary operator and its operands.
<br><br>
Additional blank lines may be added for clarity.

# Optional Features
## Static Typing
Always use static typing when possible Additionally, always explicitly declare the type of a variable. Do not use the inference operator.

```
var variable := 1 # bad
var variable: int = 1 # good
```


# Glossary
**Constant Variable:**
Variable whose value should not or cannot be changed. This does not require that the variable is explicitly a constant type.<br>
**Section:**
Description for a block of tightly related code, such as imports or function declarations.

# Example Script
```
class_name ExampleClass
extends ExampleParent


const var CONSTANT: int = 1

var regular_variable: Vector2

export(float) var exported_variable: float

onready var NODE_REFERENCE: Node = $Subnode # Pointer to a child node


func example_function(parameter: float) -> void:
    '''
    This is an example function
    It takes in parameter and returns nothing

    Note that function docstrings are optional
    (and honestly, discouraged-your names should be descriptive)
    '''

    regular_variable = Vector2.UP * (CONSTANT + exported_variable)
```
