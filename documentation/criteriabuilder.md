# Mobeelizer SDK Module

## MobeelizerCriteriaBuilder

### dictionary uniqueResult()

Find the unique entity matching to this query.

### array list()

List the entities matching to this query.

### integer count()

Count the entities matching to this query.

### MobeelizerCriteriaBuilder setMaxResults(integer maxResults)

Set the max results, by default there is no limit.

### MobeelizerCriteriaBuilder setFirstAndMaxResults(integer firstResult, integer maxResults)

Set the first result, by default the first result is equal to zero, and the max results, by default there is no limit.

### MobeelizerCriteriaBuilder add(MobeelizerCriterion criterion)

Add restriction to the query.

### MobeelizerCriteriaBuilder addOrder(MobeelizerOrder order)

Add order to the query.

## MobeelizerOrder

### MobeelizerOrder MobeelizerDatabase.Order.asc(string field)

Create ascending order for the given field.

### MobeelizerOrder MobeelizerDatabase.Order.desc(string field)

Create descending order for the given field.

## MobeelizerCriterion

### MobeelizerCriterion MobeelizerDatabase.Restriction.or(MobeelizerCriterion[] criteria)

Create restriction that joins the criteria with "OR" operator.

### MobeelizerCriterion MobeelizerDatabase.Restriction.and(MobeelizerCriterion[] criteria)

Create restriction that joins the given criteria with "AND" operator.

### MobeelizerCriterion MobeelizerDatabase.Restriction.not(MobeelizerCriterion criterion)

Wrap given criterion with "NOT" operator.

### MobeelizerCriterion MobeelizerDatabase.Restriction.guidEq(string value)

Create criterion that checks if guid is equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.guidNe(string value)

Create criterion that checks if guid isn't equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.ownerEq(string value)

Create criterion that checks if owner is equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.groupEq(string value)

Create criterion that checks if group is equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.ownerNe(string value)

Create criterion that checks if owner isn't equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.groupNe(string value)

Create criterion that checks if group isn't equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.isConflicted()

Create criterion that checks if entity is conflicted.

### MobeelizerCriterion MobeelizerDatabase.Restriction.isNotConflicted()

Create criterion that checks if entity isn't conflicted.

### MobeelizerCriterion MobeelizerDatabase.Restriction.allEq(dictionary criteria)

Create criterion that checks if all given fields match given values.

### MobeelizerCriterion MobeelizerDatabase.Restriction.like(string field, string pattern)

Create criterion that checks if field is equal (using "LIKE" operator) to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.like(string field, string pattern, string matchMode)

Create criterion that checks if field is equal (using "LIKE" operator) to the given value. Match mode: ANYWHERE, END, EXACT, START.

### MobeelizerCriterion MobeelizerDatabase.Restriction.isNull(string field)

Create criterion that checks if field is null.

### MobeelizerCriterion MobeelizerDatabase.Restriction.isNotNull(string field)

Create criterion that checks if field is not null.

### MobeelizerCriterion MobeelizerDatabase.Restriction.le(string field, object value)

Create criterion that checks if field is less than or equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.lt(string field, object value)

Create criterion that checks if field is less than the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.ge(string field, object value)

Create criterion that checks if field is greater than or equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.gt(string field, object value)

Create criterion that checks if field is greater than the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.ne(string field, object value)

Create criterion that checks if field is not equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.eq(string field, object value)

Create criterion that checks if field is equal to the given value.

### MobeelizerCriterion MobeelizerDatabase.Restriction.leField(string field, string otherField)

Create criterion that checks if field is less than or equal to the other field.

### MobeelizerCriterion MobeelizerDatabase.Restriction.ltField(string field, string otherField)

Create criterion that checks if field is less than the other field.

### MobeelizerCriterion MobeelizerDatabase.Restriction.geField(string field, string otherField)

Create criterion that checks if field is greater than or equal to the other field.

### MobeelizerCriterion MobeelizerDatabase.Restriction.gtField(string field, string otherField)

Create criterion that checks if field is greater than the other field.

### MobeelizerCriterion MobeelizerDatabase.Restriction.neField(string field, string otherField)

Create criterion that checks if field is not equal to the other field.

### MobeelizerCriterion MobeelizerDatabase.Restriction.eqField(string field, string otherField)

Create criterion that checks if field is equal to the other field.

### MobeelizerCriterion MobeelizerDatabase.Restriction.between(string field, object lo, object hi)

Create criterion that checks if field is between the given values.

### MobeelizerCriterion MobeelizerDatabase.Restriction.inArray(string field, object[] values)

Create criterion that checks if field is in the given values.

### MobeelizerCriterion MobeelizerDatabase.Restriction.belongsTo(string field, string model, string guid)

Create criterion that checks if field is equal to the entity for the given model and guid.

### MobeelizerCriterion MobeelizerDatabase.Restriction.belongsToObject(string field, dictionary entity)

Create criterion that checks if field is equal to the given entity.

### MobeelizerCriterion MobeelizerDatabase.Restriction.disjunction()

Create the disjunction - (... OR ... OR ...). Use add(MobeelizerCriterion criterion) to add criterion to this disjunction.

### MobeelizerCriterion MobeelizerDatabase.Restriction.conjunction()

Create the conjunction - (... AND ... AND ...). Use add(MobeelizerCriterion criterion) to add criterion to this conjunction.

## Usage

See example/app.js.

## Copyright

Copyright 2012 Mobeelizer Ltd

Mobeelizer SDK is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 
You should have received a copy of the GNU Affero General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA