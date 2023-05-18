import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;

part 'model.g.dart';

const SqfEntityTable tableTodo = SqfEntityTable(
  tableName: 'todos',
  primaryKeyName: 'id',
  useSoftDeleting: false,
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('title', DbType.text),
    SqfEntityField('completed', DbType.bool, defaultValue: false)
  ]
);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);


@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'MyAppDatabaseModel',
  databaseName: 'myapp-db.db',
  sequences: [seqIdentity],
  databaseTables: [tableTodo],
);