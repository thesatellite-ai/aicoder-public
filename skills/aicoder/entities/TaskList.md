# TaskList

Per-entity reference for the `TaskList` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

> ⚠ **TaskList uses `name`, NOT `title`.** Confusingly inconsistent with sibling entities — Task / Spec / Plan / Decision / Memory / Idea / Source / Notification / RunStep all use `title: String!`. TaskList, Area, Project, Label, Tag, Agent, Board, ListView, User, … use `name: String!`. Querying `taskLists { title }` fails with `Cannot query field "title" on type "TaskList"`. The split is per-entity, not by category. When in doubt, check the entity doc.

## Object type

_Defined in `ent.graphql`._

```graphql
type TaskList implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID
  ownerUserID: String!
  name: String!
  description: String
  visibility: TaskListVisibility!
  isSeeded: Boolean!
  position: Float!
  pinned: Boolean!
  archivedAt: Time
  areaID: ID
  project: Project
  ownedTasks: [Task!]
  area: Area
}
```

## Create input

```graphql
input CreateTaskListInput {
  workspaceID: String
  ownerUserID: String!
  name: String!
  description: String
  visibility: TaskListVisibility
  isSeeded: Boolean
  position: Float
  pinned: Boolean
  archivedAt: Time
  projectID: ID
  ownedTaskIDs: [ID!]
  areaID: ID
}
```

## Update input

```graphql
input UpdateTaskListInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  ownerUserID: String
  name: String
  description: String
  clearDescription: Boolean
  visibility: TaskListVisibility
  isSeeded: Boolean
  position: Float
  pinned: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  clearProject: Boolean
  addOwnedTaskIDs: [ID!]
  removeOwnedTaskIDs: [ID!]
  clearOwnedTasks: Boolean
  areaID: ID
  clearArea: Boolean
}
```

## Where filter (top-level connection)

```graphql
input TaskListWhereInput {
  not: TaskListWhereInput
  and: [TaskListWhereInput!]
  or: [TaskListWhereInput!]
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
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDIsNil: Boolean
  projectIDNotNil: Boolean
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  owner_user_id field predicates
  """
  ownerUserID: String
  ownerUserIDNEQ: String
  ownerUserIDIn: [String!]
  ownerUserIDNotIn: [String!]
  ownerUserIDGT: String
  ownerUserIDGTE: String
  ownerUserIDLT: String
  ownerUserIDLTE: String
  ownerUserIDContains: String
  ownerUserIDHasPrefix: String
  ownerUserIDHasSuffix: String
  ownerUserIDEqualFold: String
  ownerUserIDContainsFold: String
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  visibility field predicates
  """
  visibility: TaskListVisibility
  visibilityNEQ: TaskListVisibility
  visibilityIn: [TaskListVisibility!]
  visibilityNotIn: [TaskListVisibility!]
  """
  is_seeded field predicates
  """
  isSeeded: Boolean
  isSeededNEQ: Boolean
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  pinned field predicates
  """
  pinned: Boolean
  pinnedNEQ: Boolean
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  area_id field predicates
  """
  areaID: ID
  areaIDNEQ: ID
  areaIDIn: [ID!]
  areaIDNotIn: [ID!]
  areaIDGT: ID
  areaIDGTE: ID
  areaIDLT: ID
  areaIDLTE: ID
  areaIDContains: ID
  areaIDHasPrefix: ID
  areaIDHasSuffix: ID
  areaIDIsNil: Boolean
  areaIDNotNil: Boolean
  areaIDEqualFold: ID
  areaIDContainsFold: ID
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  owned_tasks edge predicates
  """
  hasOwnedTasks: Boolean
  hasOwnedTasksWith: [TaskWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
}
```

## Related queries (2)

```graphql
  """
  Resolves the actual tasks belonging to a TaskList.
  - static  → TaskListItem rows in their hand-set order.
  - virtual → tasks matching the saved Filter (viewer-aware via @me / @today / etc).
  - hybrid  → virtual base + manual pins + excludes; manual ordering applied.
  taskLists(
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
    Ordering options for TaskLists returned from the connection.
    """
    orderBy: [TaskListOrder!]
    """
    Filtering options for TaskLists returned from the connection.
    """
    where: TaskListWhereInput
  ): TaskListConnection!
```

## Related mutations (3)

```graphql
  createTaskList(input: CreateTaskListInput!): TaskList!
  seedListsForProject(projectID: ID!, ownerUserID: ID!): [TaskList!]!
  """Hard-delete a TaskList together with its tasks, subtasks, items,
     excludes, orderings, and pins. Wrapped in a single transaction."""
  updateTaskList(id: ID!, input: UpdateTaskListInput!): TaskList!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
