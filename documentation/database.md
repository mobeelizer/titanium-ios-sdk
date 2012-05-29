# Mobeelizer SDK Module

## MobeelizerDatabase

### array list(string model)

Get all entities for the given model from the database.

### dictionary findOne(string model, string guid)

Get an entity for the given model and guid. If not found return null.

### boolean exists(string model, string guid)

Check whether the entity for the given model and guid exist.

### integer count(string model)

Return the count of the entities of the given model.

### void remove(string model, string guid)

Delete the entity for the given model and guid from the database.

### void removeObject(dictionary entity)

Delete the given entity from the database.

### void removeAll(string model)

Delete all entities for the given model from the database.

### [MobeelizerErrors](errors.html) save(dictionary entity)

Save the given entity in the database and return validation errors.

### [MobeelizerCriteriaBuilder](criteriabuilder.html) find(string model)

Prepare the query builder for the given model.

## Usage

See example/app.js.

## Copyright

Copyright 2012 Mobeelizer Ltd

Mobeelizer SDK is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 
You should have received a copy of the GNU Affero General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA