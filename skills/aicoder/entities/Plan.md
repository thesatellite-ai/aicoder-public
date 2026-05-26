# Plan

Per-entity reference for the `Plan` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Plan implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  specID: ID
  title: String!
  strategy: String
  status: PlanStatus!
  approvedByUserID: String
  approvedAt: Time
  createdByUserID: String
  project: Project!
  spec: Spec
  tasks: [Task!]
  activities: [Activity!]
  convertedFromIdeas: [Idea!]
}
```

## Create input

```graphql
input CreatePlanInput {
  workspaceID: String
  title: String!
  strategy: String
  status: PlanStatus
  approvedByUserID: String
  approvedAt: Time
  createdByUserID: String
  projectID: ID!
  specID: ID
  taskIDs: [ID!]
  activityIDs: [ID!]
  convertedFromIdeaIDs: [ID!]
}
```

## Update input

```graphql
input UpdatePlanInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  strategy: String
  clearStrategy: Boolean
  status: PlanStatus
  approvedByUserID: String
  clearApprovedByUserID: Boolean
  approvedAt: Time
  clearApprovedAt: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  projectID: ID
  specID: ID
  clearSpec: Boolean
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
  addConvertedFromIdeaIDs: [ID!]
  removeConvertedFromIdeaIDs: [ID!]
  clearConvertedFromIdeas: Boolean
}
```

## Where filter (top-level connection)

```graphql
input PlanWhereInput {
  not: PlanWhereInput
  and: [PlanWhereInput!]
  or: [PlanWhereInput!]
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
  spec_id field predicates
  """
  specID: ID
  specIDNEQ: ID
  specIDIn: [ID!]
  specIDNotIn: [ID!]
  specIDGT: ID
  specIDGTE: ID
  specIDLT: ID
  specIDLTE: ID
  specIDContains: ID
  specIDHasPrefix: ID
  specIDHasSuffix: ID
  specIDIsNil: Boolean
  specIDNotNil: Boolean
  specIDEqualFold: ID
  specIDContainsFold: ID
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
  strategy field predicates
  """
  strategy: String
  strategyNEQ: String
  strategyIn: [String!]
  strategyNotIn: [String!]
  strategyGT: String
  strategyGTE: String
  strategyLT: String
  strategyLTE: String
  strategyContains: String
  strategyHasPrefix: String
  strategyHasSuffix: String
  strategyIsNil: Boolean
  strategyNotNil: Boolean
  strategyEqualFold: String
  strategyContainsFold: String
  """
  status field predicates
  """
  status: PlanStatus
  statusNEQ: PlanStatus
  statusIn: [PlanStatus!]
  statusNotIn: [PlanStatus!]
  """
  approved_by_user_id field predicates
  """
  approvedByUserID: String
  approvedByUserIDNEQ: String
  approvedByUserIDIn: [String!]
  approvedByUserIDNotIn: [String!]
  approvedByUserIDGT: String
  approvedByUserIDGTE: String
  approvedByUserIDLT: String
  approvedByUserIDLTE: String
  approvedByUserIDContains: String
  approvedByUserIDHasPrefix: String
  approvedByUserIDHasSuffix: String
  approvedByUserIDIsNil: Boolean
  approvedByUserIDNotNil: Boolean
  approvedByUserIDEqualFold: String
  approvedByUserIDContainsFold: String
  """
  approved_at field predicates
  """
  approvedAt: Time
  approvedAtNEQ: Time
  approvedAtIn: [Time!]
  approvedAtNotIn: [Time!]
  approvedAtGT: Time
  approvedAtGTE: Time
  approvedAtLT: Time
  approvedAtLTE: Time
  approvedAtIsNil: Boolean
  approvedAtNotNil: Boolean
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
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  spec edge predicates
  """
  hasSpec: Boolean
  hasSpecWith: [SpecWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
  """
  converted_from_ideas edge predicates
  """
  hasConvertedFromIdeas: Boolean
  hasConvertedFromIdeasWith: [IdeaWhereInput!]
}
```

## Related queries (1)

```graphql
  plans(
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
    Ordering options for Plans returned from the connection.
    """
    orderBy: [PlanOrder!]
    """
    Filtering options for Plans returned from the connection.
    """
    where: PlanWhereInput
  ): PlanConnection!
```

## Related mutations (4)

```graphql
  activatePlan(id: ID!): Plan!
  approvePlan(id: ID!, approvedByUserID: ID): Plan!
  createPlan(input: CreatePlanInput!): Plan!
  updatePlan(id: ID!, input: UpdatePlanInput!): Plan!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
