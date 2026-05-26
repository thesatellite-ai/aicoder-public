# Memory

Per-entity reference for the `Memory` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Memory implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: String!
  tag: MemoryTag!
  title: String!
  body: String!
  sourceTaskID: String
  sourceRunID: String
  createdByUserID: String
  createdByAgentID: String
  activities: [Activity!]
}
```

## Create input

```graphql
input CreateMemoryInput {
  workspaceID: String
  projectID: String!
  tag: MemoryTag
  title: String!
  body: String!
  sourceTaskID: String
  sourceRunID: String
  createdByUserID: String
  createdByAgentID: String
  activityIDs: [ID!]
}
```

## Update input

```graphql
input UpdateMemoryInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  projectID: String
  tag: MemoryTag
  title: String
  body: String
  sourceTaskID: String
  clearSourceTaskID: Boolean
  sourceRunID: String
  clearSourceRunID: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  createdByAgentID: String
  clearCreatedByAgentID: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
}
```

## Where filter (top-level connection)

```graphql
input MemoryWhereInput {
  not: MemoryWhereInput
  and: [MemoryWhereInput!]
  or: [MemoryWhereInput!]
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
  project_id field predicates
  """
  projectID: String
  projectIDNEQ: String
  projectIDIn: [String!]
  projectIDNotIn: [String!]
  projectIDGT: String
  projectIDGTE: String
  projectIDLT: String
  projectIDLTE: String
  projectIDContains: String
  projectIDHasPrefix: String
  projectIDHasSuffix: String
  projectIDEqualFold: String
  projectIDContainsFold: String
  """
  tag field predicates
  """
  tag: MemoryTag
  tagNEQ: MemoryTag
  tagIn: [MemoryTag!]
  tagNotIn: [MemoryTag!]
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  body field predicates
  """
  body: String
  bodyNEQ: String
  bodyIn: [String!]
  bodyNotIn: [String!]
  bodyGT: String
  bodyGTE: String
  bodyLT: String
  bodyLTE: String
  bodyContains: String
  bodyHasPrefix: String
  bodyHasSuffix: String
  bodyEqualFold: String
  bodyContainsFold: String
  """
  source_task_id field predicates
  """
  sourceTaskID: String
  sourceTaskIDNEQ: String
  sourceTaskIDIn: [String!]
  sourceTaskIDNotIn: [String!]
  sourceTaskIDGT: String
  sourceTaskIDGTE: String
  sourceTaskIDLT: String
  sourceTaskIDLTE: String
  sourceTaskIDContains: String
  sourceTaskIDHasPrefix: String
  sourceTaskIDHasSuffix: String
  sourceTaskIDIsNil: Boolean
  sourceTaskIDNotNil: Boolean
  sourceTaskIDEqualFold: String
  sourceTaskIDContainsFold: String
  """
  source_run_id field predicates
  """
  sourceRunID: String
  sourceRunIDNEQ: String
  sourceRunIDIn: [String!]
  sourceRunIDNotIn: [String!]
  sourceRunIDGT: String
  sourceRunIDGTE: String
  sourceRunIDLT: String
  sourceRunIDLTE: String
  sourceRunIDContains: String
  sourceRunIDHasPrefix: String
  sourceRunIDHasSuffix: String
  sourceRunIDIsNil: Boolean
  sourceRunIDNotNil: Boolean
  sourceRunIDEqualFold: String
  sourceRunIDContainsFold: String
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
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
}
```

## Related queries (1)

```graphql
  memories(
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
    Ordering options for Memories returned from the connection.
    """
    orderBy: [MemoryOrder!]
    """
    Filtering options for Memories returned from the connection.
    """
    where: MemoryWhereInput
  ): MemoryConnection!
```

## Related mutations (2)

```graphql
  createMemory(input: CreateMemoryInput!): Memory!
  updateMemory(id: ID!, input: UpdateMemoryInput!): Memory!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
