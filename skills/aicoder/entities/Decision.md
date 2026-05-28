# Decision

Per-entity reference for the `Decision` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Enums used by this entity

GraphQL enum literals are **bare identifiers in UPPER_SNAKE_CASE**, never quoted strings. `kind: CHOICE` not `kind: "choice"` or `kind: CHOICE`. See SKILL.md → "GraphQL gotchas".

| Enum | Valid values |
|---|---|
| `DecisionKind` | `ADR`, `BRAINSTORM`, `CHOICE` |
| `DecisionStatus` | `PROPOSED`, `ACCEPTED`, `SUPERSEDED`, `REJECTED` — **NOT `DRAFT`** (common mistake; server returns `"DRAFT is not a valid DecisionStatus"`) |

Default status on `createDecision` if omitted: **`ACCEPTED`** (verified by live probe). Set `status: PROPOSED` explicitly when you want a draft awaiting approval. `SUPERSEDED` is reserved for decisions replaced by a newer one — pair with a `supersededBy` reference if your input shape exposes it.

## Object type

_Defined in `ent.graphql`._

```graphql
type Decision implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: String!
  taskID: String
  planID: String
  runID: String
  kind: DecisionKind!
  title: String!
  context: String
  decision: String
  alternatives: [String!]
  consequences: String
  status: DecisionStatus!
  attachmentID: String
  createdByUserID: String
  createdByAgentID: String
  activities: [Activity!]
}
```

## Create input

```graphql
input CreateDecisionInput {
  workspaceID: String
  projectID: String!
  taskID: String
  planID: String
  runID: String
  kind: DecisionKind
  title: String!
  context: String
  decision: String
  alternatives: [String!]
  consequences: String
  status: DecisionStatus
  attachmentID: String
  createdByUserID: String
  createdByAgentID: String
  activityIDs: [ID!]
}
```

## Update input

```graphql
input UpdateDecisionInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  projectID: String
  taskID: String
  clearTaskID: Boolean
  planID: String
  clearPlanID: Boolean
  runID: String
  clearRunID: Boolean
  kind: DecisionKind
  title: String
  context: String
  clearContext: Boolean
  decision: String
  clearDecision: Boolean
  alternatives: [String!]
  appendAlternatives: [String!]
  clearAlternatives: Boolean
  consequences: String
  clearConsequences: Boolean
  status: DecisionStatus
  attachmentID: String
  clearAttachmentID: Boolean
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
input DecisionWhereInput {
  not: DecisionWhereInput
  and: [DecisionWhereInput!]
  or: [DecisionWhereInput!]
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
  task_id field predicates
  """
  taskID: String
  taskIDNEQ: String
  taskIDIn: [String!]
  taskIDNotIn: [String!]
  taskIDGT: String
  taskIDGTE: String
  taskIDLT: String
  taskIDLTE: String
  taskIDContains: String
  taskIDHasPrefix: String
  taskIDHasSuffix: String
  taskIDIsNil: Boolean
  taskIDNotNil: Boolean
  taskIDEqualFold: String
  taskIDContainsFold: String
  """
  plan_id field predicates
  """
  planID: String
  planIDNEQ: String
  planIDIn: [String!]
  planIDNotIn: [String!]
  planIDGT: String
  planIDGTE: String
  planIDLT: String
  planIDLTE: String
  planIDContains: String
  planIDHasPrefix: String
  planIDHasSuffix: String
  planIDIsNil: Boolean
  planIDNotNil: Boolean
  planIDEqualFold: String
  planIDContainsFold: String
  """
  run_id field predicates
  """
  runID: String
  runIDNEQ: String
  runIDIn: [String!]
  runIDNotIn: [String!]
  runIDGT: String
  runIDGTE: String
  runIDLT: String
  runIDLTE: String
  runIDContains: String
  runIDHasPrefix: String
  runIDHasSuffix: String
  runIDIsNil: Boolean
  runIDNotNil: Boolean
  runIDEqualFold: String
  runIDContainsFold: String
  """
  kind field predicates
  """
  kind: DecisionKind
  kindNEQ: DecisionKind
  kindIn: [DecisionKind!]
  kindNotIn: [DecisionKind!]
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
  context field predicates
  """
  context: String
  contextNEQ: String
  contextIn: [String!]
  contextNotIn: [String!]
  contextGT: String
  contextGTE: String
  contextLT: String
  contextLTE: String
  contextContains: String
  contextHasPrefix: String
  contextHasSuffix: String
  contextIsNil: Boolean
  contextNotNil: Boolean
  contextEqualFold: String
  contextContainsFold: String
  """
  decision field predicates
  """
  decision: String
  decisionNEQ: String
  decisionIn: [String!]
  decisionNotIn: [String!]
  decisionGT: String
  decisionGTE: String
  decisionLT: String
  decisionLTE: String
  decisionContains: String
  decisionHasPrefix: String
  decisionHasSuffix: String
  decisionIsNil: Boolean
  decisionNotNil: Boolean
  decisionEqualFold: String
  decisionContainsFold: String
  """
  consequences field predicates
  """
  consequences: String
  consequencesNEQ: String
  consequencesIn: [String!]
  consequencesNotIn: [String!]
  consequencesGT: String
  consequencesGTE: String
  consequencesLT: String
  consequencesLTE: String
  consequencesContains: String
  consequencesHasPrefix: String
  consequencesHasSuffix: String
  consequencesIsNil: Boolean
  consequencesNotNil: Boolean
  consequencesEqualFold: String
  consequencesContainsFold: String
  """
  status field predicates
  """
  status: DecisionStatus
  statusNEQ: DecisionStatus
  statusIn: [DecisionStatus!]
  statusNotIn: [DecisionStatus!]
  """
  attachment_id field predicates
  """
  attachmentID: String
  attachmentIDNEQ: String
  attachmentIDIn: [String!]
  attachmentIDNotIn: [String!]
  attachmentIDGT: String
  attachmentIDGTE: String
  attachmentIDLT: String
  attachmentIDLTE: String
  attachmentIDContains: String
  attachmentIDHasPrefix: String
  attachmentIDHasSuffix: String
  attachmentIDIsNil: Boolean
  attachmentIDNotNil: Boolean
  attachmentIDEqualFold: String
  attachmentIDContainsFold: String
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
  decisions(
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
    Ordering options for Decisions returned from the connection.
    """
    orderBy: [DecisionOrder!]
    """
    Filtering options for Decisions returned from the connection.
    """
    where: DecisionWhereInput
  ): DecisionConnection!
```

## Related mutations (2)

```graphql
  createDecision(input: CreateDecisionInput!): Decision!
  updateDecision(id: ID!, input: UpdateDecisionInput!): Decision!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
