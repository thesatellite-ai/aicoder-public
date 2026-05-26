# TaskLink

Per-entity reference for the `TaskLink` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type TaskLink implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taskID: ID!
  targetTaskID: String!
  kind: TaskLinkKind!
  createdByUserID: String
  createdByAgentID: String
  task: Task!
}
```

## Create input

```graphql
input CreateTaskLinkInput {
  workspaceID: String
  targetTaskID: String!
  kind: TaskLinkKind!
  createdByUserID: String
  createdByAgentID: String
  taskID: ID!
}
```

## Where filter (top-level connection)

```graphql
input TaskLinkWhereInput {
  not: TaskLinkWhereInput
  and: [TaskLinkWhereInput!]
  or: [TaskLinkWhereInput!]
  """
  id field predicates
  """
  id: ID
  idNEQ: ID
  idIn: [ID!]
  idNotIn: [ID!]
  idGT: ID
  idGTE: ID
  idLT: ID
  idLTE: ID
  idEqualFold: ID
  idContainsFold: ID
  """
  workspace_id field predicates
  """
  workspaceID: String
  workspaceIDNEQ: String
  workspaceIDIn: [String!]
  workspaceIDNotIn: [String!]
  workspaceIDGT: String
  workspaceIDGTE: String
  workspaceIDLT: String
  workspaceIDLTE: String
  workspaceIDContains: String
  workspaceIDHasPrefix: String
  workspaceIDHasSuffix: String
  workspaceIDIsNil: Boolean
  workspaceIDNotNil: Boolean
  workspaceIDEqualFold: String
  workspaceIDContainsFold: String
  """
  created_at field predicates
  """
  createdAt: Time
  createdAtNEQ: Time
  createdAtIn: [Time!]
  createdAtNotIn: [Time!]
  createdAtGT: Time
  createdAtGTE: Time
  createdAtLT: Time
  createdAtLTE: Time
  createdAtIsNil: Boolean
  createdAtNotNil: Boolean
  """
  updated_at field predicates
  """
  updatedAt: Time
  updatedAtNEQ: Time
  updatedAtIn: [Time!]
  updatedAtNotIn: [Time!]
  updatedAtGT: Time
  updatedAtGTE: Time
  updatedAtLT: Time
  updatedAtLTE: Time
  updatedAtIsNil: Boolean
  updatedAtNotNil: Boolean
  """
  task_id field predicates
  """
  taskID: ID
  taskIDNEQ: ID
  taskIDIn: [ID!]
  taskIDNotIn: [ID!]
  taskIDGT: ID
  taskIDGTE: ID
  taskIDLT: ID
  taskIDLTE: ID
  taskIDContains: ID
  taskIDHasPrefix: ID
  taskIDHasSuffix: ID
  taskIDEqualFold: ID
  taskIDContainsFold: ID
  """
  target_task_id field predicates
  """
  targetTaskID: String
  targetTaskIDNEQ: String
  targetTaskIDIn: [String!]
  targetTaskIDNotIn: [String!]
  targetTaskIDGT: String
  targetTaskIDGTE: String
  targetTaskIDLT: String
  targetTaskIDLTE: String
  targetTaskIDContains: String
  targetTaskIDHasPrefix: String
  targetTaskIDHasSuffix: String
  targetTaskIDEqualFold: String
  targetTaskIDContainsFold: String
  """
  kind field predicates
  """
  kind: TaskLinkKind
  kindNEQ: TaskLinkKind
  kindIn: [TaskLinkKind!]
  kindNotIn: [TaskLinkKind!]
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  created_by_agent_id field predicates
  """
  createdByAgentID: String
  createdByAgentIDNEQ: String
  createdByAgentIDIn: [String!]
  createdByAgentIDNotIn: [String!]
  createdByAgentIDGT: String
  createdByAgentIDGTE: String
  createdByAgentIDLT: String
  createdByAgentIDLTE: String
  createdByAgentIDContains: String
  createdByAgentIDHasPrefix: String
  createdByAgentIDHasSuffix: String
  createdByAgentIDIsNil: Boolean
  createdByAgentIDNotNil: Boolean
  createdByAgentIDEqualFold: String
  createdByAgentIDContainsFold: String
  """
  task edge predicates
  """
  hasTask: Boolean
  hasTaskWith: [TaskWhereInput!]
}
```

## Related queries (1)

```graphql
  taskLinks(
    """
    Returns the elements in the list that come after the specified cursor.
    """
    after: Cursor
    """
    Returns the first _n_ elements from the list.
    """
    first: Int
    """
    Returns the elements in the list that come before the specified cursor.
    """
    before: Cursor
    """
    Returns the last _n_ elements from the list.
    """
    last: Int
    """
    Ordering options for TaskLinks returned from the connection.
    """
    orderBy: [TaskLinkOrder!]
    """
    Filtering options for TaskLinks returned from the connection.
    """
    where: TaskLinkWhereInput
  ): TaskLinkConnection!
```

## Related mutations (1)

```graphql
  addTaskLink(taskID: ID!, targetTaskID: ID!, kind: TaskLinkKind!): TaskLink!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
