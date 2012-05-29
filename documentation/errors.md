# Mobeelizer SDK Module

## MobeelizerErrors

### boolean isValid()

Check if entity is valid - doesn't contain any global or field's errors.

### boolean isFieldValid(string field)

Check if field is valid.

### array getErrors()

The array of global errors. Error is a dictionary that contains code, message and args elements.

### array getFieldErrors(string field)

The array of field's errors. Error is a dictionary that contains code, message and args elements.

## Usage

See example/app.js.

## Copyright

Copyright 2012 Mobeelizer Ltd

Mobeelizer SDK is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 
You should have received a copy of the GNU Affero General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA