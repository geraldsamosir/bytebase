import * as monaco from "monaco-editor";

import { InstanceId, DatabaseId, TableId } from "../types";

export type EditorModel = monaco.editor.ITextModel;
export type EditorPosition = monaco.Position;
export type CompletionItems = monaco.languages.CompletionItem[];

export enum SortText {
  TABLE = "0",
  COLUMN = "1",
  KEYWORD = "2",
  DATABASE = "3",
  INSTASNCE = "4",
}

export type ConnectionMeta = {
  instanceId: InstanceId;
  instanceName: string;
  databaseId: DatabaseId;
  databaseName: string;
  tableId: TableId;
  tableName: string;
};
