# Project

Per-entity reference for the `Project` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Project implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  name: String!
  description: String
  status: String!
  directories: [ProjectDirectory!]
  markdownFiles: [MarkdownFile!]
  termSessions: [TermSession!]
  workspaceLayouts: [WorkspaceLayout!]
  boards: [Board!]
  tasks: [Task!]
  labels: [Label!]
  taskLists: [TaskList!]
  specs: [Spec!]
  plans: [Plan!]
  ideas: [Idea!]
  areas: [Area!]
  sources: [Source!]
  members: [ProjectMember!]
  listViews: [ListView!]
}
```

## Create input

```graphql
input CreateProjectInput {
  workspaceID: String
  name: String!
  description: String
  status: String
  directoryIDs: [ID!]
  markdownFileIDs: [ID!]
  termSessionIDs: [ID!]
  workspaceLayoutIDs: [ID!]
  boardIDs: [ID!]
  taskIDs: [ID!]
  labelIDs: [ID!]
  taskListIDs: [ID!]
  specIDs: [ID!]
  planIDs: [ID!]
  ideaIDs: [ID!]
  areaIDs: [ID!]
  sourceIDs: [ID!]
  memberIDs: [ID!]
  listViewIDs: [ID!]
}
```

## Update input

```graphql
input UpdateProjectInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  description: String
  clearDescription: Boolean
  status: String
  addDirectoryIDs: [ID!]
  removeDirectoryIDs: [ID!]
  clearDirectories: Boolean
  addMarkdownFileIDs: [ID!]
  removeMarkdownFileIDs: [ID!]
  clearMarkdownFiles: Boolean
  addTermSessionIDs: [ID!]
  removeTermSessionIDs: [ID!]
  clearTermSessions: Boolean
  addWorkspaceLayoutIDs: [ID!]
  removeWorkspaceLayoutIDs: [ID!]
  clearWorkspaceLayouts: Boolean
  addBoardIDs: [ID!]
  removeBoardIDs: [ID!]
  clearBoards: Boolean
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
  addLabelIDs: [ID!]
  removeLabelIDs: [ID!]
  clearLabels: Boolean
  addTaskListIDs: [ID!]
  removeTaskListIDs: [ID!]
  clearTaskLists: Boolean
  addSpecIDs: [ID!]
  removeSpecIDs: [ID!]
  clearSpecs: Boolean
  addPlanIDs: [ID!]
  removePlanIDs: [ID!]
  clearPlans: Boolean
  addIdeaIDs: [ID!]
  removeIdeaIDs: [ID!]
  clearIdeas: Boolean
  addAreaIDs: [ID!]
  removeAreaIDs: [ID!]
  clearAreas: Boolean
  addSourceIDs: [ID!]
  removeSourceIDs: [ID!]
  clearSources: Boolean
  addMemberIDs: [ID!]
  removeMemberIDs: [ID!]
  clearMembers: Boolean
  addListViewIDs: [ID!]
  removeListViewIDs: [ID!]
  clearListViews: Boolean
}
```

## Where filter (top-level connection)

```graphql
input ProjectWhereInput {
  not: ProjectWhereInput
  and: [ProjectWhereInput!]
  or: [ProjectWhereInput!]
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
  status field predicates
  """
  status: String
  statusNEQ: String
  statusIn: [String!]
  statusNotIn: [String!]
  statusGT: String
  statusGTE: String
  statusLT: String
  statusLTE: String
  statusContains: String
  statusHasPrefix: String
  statusHasSuffix: String
  statusEqualFold: String
  statusContainsFold: String
  """
  directories edge predicates
  """
  hasDirectories: Boolean
  hasDirectoriesWith: [ProjectDirectoryWhereInput!]
  """
  markdown_files edge predicates
  """
  hasMarkdownFiles: Boolean
  hasMarkdownFilesWith: [MarkdownFileWhereInput!]
  """
  term_sessions edge predicates
  """
  hasTermSessions: Boolean
  hasTermSessionsWith: [TermSessionWhereInput!]
  """
  workspace_layouts edge predicates
  """
  hasWorkspaceLayouts: Boolean
  hasWorkspaceLayoutsWith: [WorkspaceLayoutWhereInput!]
  """
  boards edge predicates
  """
  hasBoards: Boolean
  hasBoardsWith: [BoardWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
  """
  labels edge predicates
  """
  hasLabels: Boolean
  hasLabelsWith: [LabelWhereInput!]
  """
  task_lists edge predicates
  """
  hasTaskLists: Boolean
  hasTaskListsWith: [TaskListWhereInput!]
  """
  specs edge predicates
  """
  hasSpecs: Boolean
  hasSpecsWith: [SpecWhereInput!]
  """
  plans edge predicates
  """
  hasPlans: Boolean
  hasPlansWith: [PlanWhereInput!]
  """
  ideas edge predicates
  """
  hasIdeas: Boolean
  hasIdeasWith: [IdeaWhereInput!]
  """
  areas edge predicates
  """
  hasAreas: Boolean
  hasAreasWith: [AreaWhereInput!]
  """
  sources edge predicates
  """
  hasSources: Boolean
  hasSourcesWith: [SourceWhereInput!]
  """
  members edge predicates
  """
  hasMembers: Boolean
  hasMembersWith: [ProjectMemberWhereInput!]
  """
  list_views edge predicates
  """
  hasListViews: Boolean
  hasListViewsWith: [ListViewWhereInput!]
}
```

## Related queries (1)

```graphql
  projects(
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
    Ordering options for Projects returned from the connection.
    """
    orderBy: [ProjectOrder!]
    """
    Filtering options for Projects returned from the connection.
    """
    where: ProjectWhereInput
  ): ProjectConnection!
```

## Related mutations (2)

```graphql
  createProject(input: CreateProjectInput!): Project!
  """Update a project"""
  updateProject(id: ID!, input: UpdateProjectInput!): Project!
  """Delete a project"""
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
