# Area

Per-entity reference for the `Area` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Area implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  name: String!
  slug: String!
  description: String
  status: AreaStatus!
  leadUserID: String
  position: Float!
  archivedAt: Time
  project: Project!
  ideas: [Idea!]
  tasks: [Task!]
  taskLists: [TaskList!]
  sources: [Source!]
}
```

## Create input

```graphql
input CreateAreaInput {
  workspaceID: String
  name: String!
  slug: String!
  description: String
  status: AreaStatus
  leadUserID: String
  position: Float
  archivedAt: Time
  projectID: ID!
  ideaIDs: [ID!]
  taskIDs: [ID!]
  taskListIDs: [ID!]
  sourceIDs: [ID!]
}
```

## Update input

```graphql
input UpdateAreaInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  slug: String
  description: String
  clearDescription: Boolean
  status: AreaStatus
  leadUserID: String
  clearLeadUserID: Boolean
  position: Float
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  addIdeaIDs: [ID!]
  removeIdeaIDs: [ID!]
  clearIdeas: Boolean
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
  addTaskListIDs: [ID!]
  removeTaskListIDs: [ID!]
  clearTaskLists: Boolean
  addSourceIDs: [ID!]
  removeSourceIDs: [ID!]
  clearSources: Boolean
}
```

## Where filter (top-level connection)

```graphql
input AreaWhereInput {
  not: AreaWhereInput
  and: [AreaWhereInput!]
  or: [AreaWhereInput!]
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
  projectIDEqualFold: ID
  projectIDContainsFold: ID
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
  slug field predicates
  """
  slug: String
  slugNEQ: String
  slugIn: [String!]
  slugNotIn: [String!]
  slugGT: String
  slugGTE: String
  slugLT: String
  slugLTE: String
  slugContains: String
  slugHasPrefix: String
  slugHasSuffix: String
  slugEqualFold: String
  slugContainsFold: String
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
  status field predicates
  """
  status: AreaStatus
  statusNEQ: AreaStatus
  statusIn: [AreaStatus!]
  statusNotIn: [AreaStatus!]
  """
  lead_user_id field predicates
  """
  leadUserID: String
  leadUserIDNEQ: String
  leadUserIDIn: [String!]
  leadUserIDNotIn: [String!]
  leadUserIDGT: String
  leadUserIDGTE: String
  leadUserIDLT: String
  leadUserIDLTE: String
  leadUserIDContains: String
  leadUserIDHasPrefix: String
  leadUserIDHasSuffix: String
  leadUserIDIsNil: Boolean
  leadUserIDNotNil: Boolean
  leadUserIDEqualFold: String
  leadUserIDContainsFold: String
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
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  ideas edge predicates
  """
  hasIdeas: Boolean
  hasIdeasWith: [IdeaWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
  """
  task_lists edge predicates
  """
  hasTaskLists: Boolean
  hasTaskListsWith: [TaskListWhereInput!]
  """
  sources edge predicates
  """
  hasSources: Boolean
  hasSourcesWith: [SourceWhereInput!]
}
```

## Related queries (1)

```graphql
  areas(
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
    Ordering options for Areas returned from the connection.
    """
    orderBy: [AreaOrder!]
    """
    Filtering options for Areas returned from the connection.
    """
    where: AreaWhereInput
  ): AreaConnection!
```

## Related mutations (3)

```graphql
  createArea(input: CreateAreaInput!): Area!
  ensureAreaByName(projectID: ID!, name: String!): Area!
  updateArea(id: ID!, input: UpdateAreaInput!): Area!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
