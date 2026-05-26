# TaskTemplate

Per-entity reference for the `TaskTemplate` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type TaskTemplate implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: String
  ownerUserID: String
  name: String!
  description: String
  defaultKind: String
  defaultPriority: String
  defaultEffort: String
  defaultAgentKind: String
  defaultAgentID: String
  defaultRetryPolicy: Map
  defaultTimeoutSeconds: Int
  defaultMaxCostUsd: Float
  defaultRequiresReview: Boolean!
  defaultAcceptanceCriteria: [String!]
  inputSchema: Map
  outputSchema: Map
  descriptionTemplate: String
  archivedAt: Time
}
```

## Create input

```graphql
input CreateTaskTemplateInput {
  workspaceID: String
  projectID: String
  ownerUserID: String
  name: String!
  description: String
  defaultKind: String
  defaultPriority: String
  defaultEffort: String
  defaultAgentKind: String
  defaultAgentID: String
  defaultTimeoutSeconds: Int
  defaultMaxCostUsd: Float
  defaultRequiresReview: Boolean
  descriptionTemplate: String
  archivedAt: Time
}
```

## Update input

```graphql
input UpdateTaskTemplateInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  projectID: String
  clearProjectID: Boolean
  ownerUserID: String
  clearOwnerUserID: Boolean
  name: String
  description: String
  clearDescription: Boolean
  defaultKind: String
  clearDefaultKind: Boolean
  defaultPriority: String
  clearDefaultPriority: Boolean
  defaultEffort: String
  clearDefaultEffort: Boolean
  defaultAgentKind: String
  clearDefaultAgentKind: Boolean
  defaultAgentID: String
  clearDefaultAgentID: Boolean
  defaultTimeoutSeconds: Int
  clearDefaultTimeoutSeconds: Boolean
  defaultMaxCostUsd: Float
  clearDefaultMaxCostUsd: Boolean
  defaultRequiresReview: Boolean
  descriptionTemplate: String
  clearDescriptionTemplate: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
}
```

## Where filter (top-level connection)

```graphql
input TaskTemplateWhereInput {
  not: TaskTemplateWhereInput
  and: [TaskTemplateWhereInput!]
  or: [TaskTemplateWhereInput!]
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
  projectIDIsNil: Boolean
  projectIDNotNil: Boolean
  projectIDEqualFold: String
  projectIDContainsFold: String
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
  ownerUserIDIsNil: Boolean
  ownerUserIDNotNil: Boolean
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
  default_kind field predicates
  """
  defaultKind: String
  defaultKindNEQ: String
  defaultKindIn: [String!]
  defaultKindNotIn: [String!]
  defaultKindGT: String
  defaultKindGTE: String
  defaultKindLT: String
  defaultKindLTE: String
  defaultKindContains: String
  defaultKindHasPrefix: String
  defaultKindHasSuffix: String
  defaultKindIsNil: Boolean
  defaultKindNotNil: Boolean
  defaultKindEqualFold: String
  defaultKindContainsFold: String
  """
  default_priority field predicates
  """
  defaultPriority: String
  defaultPriorityNEQ: String
  defaultPriorityIn: [String!]
  defaultPriorityNotIn: [String!]
  defaultPriorityGT: String
  defaultPriorityGTE: String
  defaultPriorityLT: String
  defaultPriorityLTE: String
  defaultPriorityContains: String
  defaultPriorityHasPrefix: String
  defaultPriorityHasSuffix: String
  defaultPriorityIsNil: Boolean
  defaultPriorityNotNil: Boolean
  defaultPriorityEqualFold: String
  defaultPriorityContainsFold: String
  """
  default_effort field predicates
  """
  defaultEffort: String
  defaultEffortNEQ: String
  defaultEffortIn: [String!]
  defaultEffortNotIn: [String!]
  defaultEffortGT: String
  defaultEffortGTE: String
  defaultEffortLT: String
  defaultEffortLTE: String
  defaultEffortContains: String
  defaultEffortHasPrefix: String
  defaultEffortHasSuffix: String
  defaultEffortIsNil: Boolean
  defaultEffortNotNil: Boolean
  defaultEffortEqualFold: String
  defaultEffortContainsFold: String
  """
  default_agent_kind field predicates
  """
  defaultAgentKind: String
  defaultAgentKindNEQ: String
  defaultAgentKindIn: [String!]
  defaultAgentKindNotIn: [String!]
  defaultAgentKindGT: String
  defaultAgentKindGTE: String
  defaultAgentKindLT: String
  defaultAgentKindLTE: String
  defaultAgentKindContains: String
  defaultAgentKindHasPrefix: String
  defaultAgentKindHasSuffix: String
  defaultAgentKindIsNil: Boolean
  defaultAgentKindNotNil: Boolean
  defaultAgentKindEqualFold: String
  defaultAgentKindContainsFold: String
  """
  default_agent_id field predicates
  """
  defaultAgentID: String
  defaultAgentIDNEQ: String
  defaultAgentIDIn: [String!]
  defaultAgentIDNotIn: [String!]
  defaultAgentIDGT: String
  defaultAgentIDGTE: String
  defaultAgentIDLT: String
  defaultAgentIDLTE: String
  defaultAgentIDContains: String
  defaultAgentIDHasPrefix: String
  defaultAgentIDHasSuffix: String
  defaultAgentIDIsNil: Boolean
  defaultAgentIDNotNil: Boolean
  defaultAgentIDEqualFold: String
  defaultAgentIDContainsFold: String
  """
  default_timeout_seconds field predicates
  """
  defaultTimeoutSeconds: Int
  defaultTimeoutSecondsNEQ: Int
  defaultTimeoutSecondsIn: [Int!]
  defaultTimeoutSecondsNotIn: [Int!]
  defaultTimeoutSecondsGT: Int
  defaultTimeoutSecondsGTE: Int
  defaultTimeoutSecondsLT: Int
  defaultTimeoutSecondsLTE: Int
  defaultTimeoutSecondsIsNil: Boolean
  defaultTimeoutSecondsNotNil: Boolean
  """
  default_max_cost_usd field predicates
  """
  defaultMaxCostUsd: Float
  defaultMaxCostUsdNEQ: Float
  defaultMaxCostUsdIn: [Float!]
  defaultMaxCostUsdNotIn: [Float!]
  defaultMaxCostUsdGT: Float
  defaultMaxCostUsdGTE: Float
  defaultMaxCostUsdLT: Float
  defaultMaxCostUsdLTE: Float
  defaultMaxCostUsdIsNil: Boolean
  defaultMaxCostUsdNotNil: Boolean
  """
  default_requires_review field predicates
  """
  defaultRequiresReview: Boolean
  defaultRequiresReviewNEQ: Boolean
  """
  description_template field predicates
  """
  descriptionTemplate: String
  descriptionTemplateNEQ: String
  descriptionTemplateIn: [String!]
  descriptionTemplateNotIn: [String!]
  descriptionTemplateGT: String
  descriptionTemplateGTE: String
  descriptionTemplateLT: String
  descriptionTemplateLTE: String
  descriptionTemplateContains: String
  descriptionTemplateHasPrefix: String
  descriptionTemplateHasSuffix: String
  descriptionTemplateIsNil: Boolean
  descriptionTemplateNotNil: Boolean
  descriptionTemplateEqualFold: String
  descriptionTemplateContainsFold: String
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
}
```

## Related queries (1)

```graphql
  taskTemplates(
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
    Ordering options for TaskTemplates returned from the connection.
    """
    orderBy: [TaskTemplateOrder!]
    """
    Filtering options for TaskTemplates returned from the connection.
    """
    where: TaskTemplateWhereInput
  ): TaskTemplateConnection!
```

## Related mutations (2)

```graphql
  createTaskTemplate(input: CreateTaskTemplateInput!): TaskTemplate!
  updateTaskTemplate(id: ID!, input: UpdateTaskTemplateInput!): TaskTemplate!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
