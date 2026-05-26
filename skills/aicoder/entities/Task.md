# Task

Per-entity reference for the `Task` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Task implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  boardID: ID!
  ownerListID: ID
  areaID: ID
  parentTaskID: ID
  title: String!
  description: String
  kind: TaskKind!
  status: String!
  priority: TaskPriority!
  effort: TaskEffort!
  estimateHours: Float
  position: Float!
  dueDate: Time
  assigneeUserID: String
  assigneeAgentID: String
  createdByUserID: String
  blockedReason: String
  startedAt: Time
  finishedAt: Time
  archivedAt: Time
  lastActivityAt: Time!
  requiresReview: Boolean!
  planReviewRequired: Boolean!
  project: Project!
  board: Board!
  ownerList: TaskList
  area: Area
  subtasks: [Task!]
  parent: Task
  activities: [Activity!]
  attachments: [Attachment!]
  labels: [Label!]
  links: [TaskLink!]
  runs: [Run!]
  reviews: [Review!]
  plans: [Plan!]
  convertedFromIdeas: [Idea!]
  assignees: [TaskAssignee!]
}
```

## Create input

```graphql
input CreateTaskInput {
  workspaceID: String
  title: String!
  description: String
  kind: TaskKind
  status: String
  priority: TaskPriority
  effort: TaskEffort
  estimateHours: Float
  position: Float
  dueDate: Time
  assigneeUserID: String
  assigneeAgentID: String
  createdByUserID: String
  blockedReason: String
  startedAt: Time
  finishedAt: Time
  archivedAt: Time
  lastActivityAt: Time
  requiresReview: Boolean
  planReviewRequired: Boolean
  projectID: ID!
  boardID: ID!
  ownerListID: ID
  areaID: ID
  subtaskIDs: [ID!]
  parentID: ID
  activityIDs: [ID!]
  attachmentIDs: [ID!]
  labelIDs: [ID!]
  linkIDs: [ID!]
  runIDs: [ID!]
  reviewIDs: [ID!]
  planIDs: [ID!]
  convertedFromIdeaIDs: [ID!]
  assigneeIDs: [ID!]
}
```

## Update input

```graphql
input UpdateTaskInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  description: String
  clearDescription: Boolean
  kind: TaskKind
  status: String
  priority: TaskPriority
  effort: TaskEffort
  estimateHours: Float
  clearEstimateHours: Boolean
  position: Float
  dueDate: Time
  clearDueDate: Boolean
  assigneeUserID: String
  clearAssigneeUserID: Boolean
  assigneeAgentID: String
  clearAssigneeAgentID: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  blockedReason: String
  clearBlockedReason: Boolean
  startedAt: Time
  clearStartedAt: Boolean
  finishedAt: Time
  clearFinishedAt: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  lastActivityAt: Time
  requiresReview: Boolean
  planReviewRequired: Boolean
  projectID: ID
  boardID: ID
  ownerListID: ID
  clearOwnerList: Boolean
  areaID: ID
  clearArea: Boolean
  addSubtaskIDs: [ID!]
  removeSubtaskIDs: [ID!]
  clearSubtasks: Boolean
  parentID: ID
  clearParent: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
  addAttachmentIDs: [ID!]
  removeAttachmentIDs: [ID!]
  clearAttachments: Boolean
  addLabelIDs: [ID!]
  removeLabelIDs: [ID!]
  clearLabels: Boolean
  addLinkIDs: [ID!]
  removeLinkIDs: [ID!]
  clearLinks: Boolean
  addRunIDs: [ID!]
  removeRunIDs: [ID!]
  clearRuns: Boolean
  addReviewIDs: [ID!]
  removeReviewIDs: [ID!]
  clearReviews: Boolean
  addPlanIDs: [ID!]
  removePlanIDs: [ID!]
  clearPlans: Boolean
  addConvertedFromIdeaIDs: [ID!]
  removeConvertedFromIdeaIDs: [ID!]
  clearConvertedFromIdeas: Boolean
  addAssigneeIDs: [ID!]
  removeAssigneeIDs: [ID!]
  clearAssignees: Boolean
}
```

## Where filter (top-level connection)

```graphql
input TaskWhereInput {
  not: TaskWhereInput
  and: [TaskWhereInput!]
  or: [TaskWhereInput!]
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
  board_id field predicates
  """
  boardID: ID
  boardIDNEQ: ID
  boardIDIn: [ID!]
  boardIDNotIn: [ID!]
  boardIDGT: ID
  boardIDGTE: ID
  boardIDLT: ID
  boardIDLTE: ID
  boardIDContains: ID
  boardIDHasPrefix: ID
  boardIDHasSuffix: ID
  boardIDEqualFold: ID
  boardIDContainsFold: ID
  """
  owner_list_id field predicates
  """
  ownerListID: ID
  ownerListIDNEQ: ID
  ownerListIDIn: [ID!]
  ownerListIDNotIn: [ID!]
  ownerListIDGT: ID
  ownerListIDGTE: ID
  ownerListIDLT: ID
  ownerListIDLTE: ID
  ownerListIDContains: ID
  ownerListIDHasPrefix: ID
  ownerListIDHasSuffix: ID
  ownerListIDIsNil: Boolean
  ownerListIDNotNil: Boolean
  ownerListIDEqualFold: ID
  ownerListIDContainsFold: ID
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
  parent_task_id field predicates
  """
  parentTaskID: ID
  parentTaskIDNEQ: ID
  parentTaskIDIn: [ID!]
  parentTaskIDNotIn: [ID!]
  parentTaskIDGT: ID
  parentTaskIDGTE: ID
  parentTaskIDLT: ID
  parentTaskIDLTE: ID
  parentTaskIDContains: ID
  parentTaskIDHasPrefix: ID
  parentTaskIDHasSuffix: ID
  parentTaskIDIsNil: Boolean
  parentTaskIDNotNil: Boolean
  parentTaskIDEqualFold: ID
  parentTaskIDContainsFold: ID
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
  kind field predicates
  """
  kind: TaskKind
  kindNEQ: TaskKind
  kindIn: [TaskKind!]
  kindNotIn: [TaskKind!]
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
  priority field predicates
  """
  priority: TaskPriority
  priorityNEQ: TaskPriority
  priorityIn: [TaskPriority!]
  priorityNotIn: [TaskPriority!]
  """
  effort field predicates
  """
  effort: TaskEffort
  effortNEQ: TaskEffort
  effortIn: [TaskEffort!]
  effortNotIn: [TaskEffort!]
  """
  estimate_hours field predicates
  """
  estimateHours: Float
  estimateHoursNEQ: Float
  estimateHoursIn: [Float!]
  estimateHoursNotIn: [Float!]
  estimateHoursGT: Float
  estimateHoursGTE: Float
  estimateHoursLT: Float
  estimateHoursLTE: Float
  estimateHoursIsNil: Boolean
  estimateHoursNotNil: Boolean
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
  due_date field predicates
  """
  dueDate: Time
  dueDateNEQ: Time
  dueDateIn: [Time!]
  dueDateNotIn: [Time!]
  dueDateGT: Time
  dueDateGTE: Time
  dueDateLT: Time
  dueDateLTE: Time
  dueDateIsNil: Boolean
  dueDateNotNil: Boolean
  """
  assignee_user_id field predicates
  """
  assigneeUserID: String
  assigneeUserIDNEQ: String
  assigneeUserIDIn: [String!]
  assigneeUserIDNotIn: [String!]
  assigneeUserIDGT: String
  assigneeUserIDGTE: String
  assigneeUserIDLT: String
  assigneeUserIDLTE: String
  assigneeUserIDContains: String
  assigneeUserIDHasPrefix: String
  assigneeUserIDHasSuffix: String
  assigneeUserIDIsNil: Boolean
  assigneeUserIDNotNil: Boolean
  assigneeUserIDEqualFold: String
  assigneeUserIDContainsFold: String
  """
  assignee_agent_id field predicates
  """
  assigneeAgentID: String
  assigneeAgentIDNEQ: String
  assigneeAgentIDIn: [String!]
  assigneeAgentIDNotIn: [String!]
  assigneeAgentIDGT: String
  assigneeAgentIDGTE: String
  assigneeAgentIDLT: String
  assigneeAgentIDLTE: String
  assigneeAgentIDContains: String
  assigneeAgentIDHasPrefix: String
  assigneeAgentIDHasSuffix: String
  assigneeAgentIDIsNil: Boolean
  assigneeAgentIDNotNil: Boolean
  assigneeAgentIDEqualFold: String
  assigneeAgentIDContainsFold: String
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
  blocked_reason field predicates
  """
  blockedReason: String
  blockedReasonNEQ: String
  blockedReasonIn: [String!]
  blockedReasonNotIn: [String!]
  blockedReasonGT: String
  blockedReasonGTE: String
  blockedReasonLT: String
  blockedReasonLTE: String
  blockedReasonContains: String
  blockedReasonHasPrefix: String
  blockedReasonHasSuffix: String
  blockedReasonIsNil: Boolean
  blockedReasonNotNil: Boolean
  blockedReasonEqualFold: String
  blockedReasonContainsFold: String
  """
  started_at field predicates
  """
  startedAt: Time
  startedAtNEQ: Time
  startedAtIn: [Time!]
  startedAtNotIn: [Time!]
  startedAtGT: Time
  startedAtGTE: Time
  startedAtLT: Time
  startedAtLTE: Time
  startedAtIsNil: Boolean
  startedAtNotNil: Boolean
  """
  finished_at field predicates
  """
  finishedAt: Time
  finishedAtNEQ: Time
  finishedAtIn: [Time!]
  finishedAtNotIn: [Time!]
  finishedAtGT: Time
  finishedAtGTE: Time
  finishedAtLT: Time
  finishedAtLTE: Time
  finishedAtIsNil: Boolean
  finishedAtNotNil: Boolean
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
  last_activity_at field predicates
  """
  lastActivityAt: Time
  lastActivityAtNEQ: Time
  lastActivityAtIn: [Time!]
  lastActivityAtNotIn: [Time!]
  lastActivityAtGT: Time
  lastActivityAtGTE: Time
  lastActivityAtLT: Time
  lastActivityAtLTE: Time
  """
  requires_review field predicates
  """
  requiresReview: Boolean
  requiresReviewNEQ: Boolean
  """
  plan_review_required field predicates
  """
  planReviewRequired: Boolean
  planReviewRequiredNEQ: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  board edge predicates
  """
  hasBoard: Boolean
  hasBoardWith: [BoardWhereInput!]
  """
  owner_list edge predicates
  """
  hasOwnerList: Boolean
  hasOwnerListWith: [TaskListWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
  """
  subtasks edge predicates
  """
  hasSubtasks: Boolean
  hasSubtasksWith: [TaskWhereInput!]
  """
  parent edge predicates
  """
  hasParent: Boolean
  hasParentWith: [TaskWhereInput!]
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
  """
  attachments edge predicates
  """
  hasAttachments: Boolean
  hasAttachmentsWith: [AttachmentWhereInput!]
  """
  labels edge predicates
  """
  hasLabels: Boolean
  hasLabelsWith: [LabelWhereInput!]
  """
  links edge predicates
  """
  hasLinks: Boolean
  hasLinksWith: [TaskLinkWhereInput!]
  """
  runs edge predicates
  """
  hasRuns: Boolean
  hasRunsWith: [RunWhereInput!]
  """
  reviews edge predicates
  """
  hasReviews: Boolean
  hasReviewsWith: [ReviewWhereInput!]
  """
  plans edge predicates
  """
  hasPlans: Boolean
  hasPlansWith: [PlanWhereInput!]
  """
  converted_from_ideas edge predicates
  """
  hasConvertedFromIdeas: Boolean
  hasConvertedFromIdeasWith: [IdeaWhereInput!]
  """
  assignees edge predicates
  """
  hasAssignees: Boolean
  hasAssigneesWith: [TaskAssigneeWhereInput!]
}
```

## Related queries (3)

```graphql
  resolveListView(
    viewID: ID!
    viewerUserID: ID!
    limit: Int
    offset: Int
    search: String
    statusIn: [String!]
    priorityIn: [String!]
  ): [Task!]!
  """Total visible task count for a view (same filter args as resolveListView)."""
  resolveTaskList(
    listID: ID!
    viewerUserID: ID!
    limit: Int
    offset: Int
    search: String
    statusIn: [String!]
    priorityIn: [String!]
  ): [Task!]!
  """Total task count for a list. Honours the same search + filter args as
     resolveTaskList so the count matches the visible set."""
  tasks(
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
    Ordering options for Tasks returned from the connection.
    """
    orderBy: [TaskOrder!]
    """
    Filtering options for Tasks returned from the connection.
    """
    where: TaskWhereInput
  ): TaskConnection!
```

## Related mutations (10)

```graphql
  archiveTask(taskID: ID!): Task!
  assignTask(taskID: ID!, userID: ID, agentID: ID): Task!
  """Add a user to the task's collaborators (many-to-many junction). Idempotent —
     re-adding an active assignee returns the existing row."""
  attachLabel(taskID: ID!, labelID: ID!): Task!
  createTask(input: CreateTaskInput!): Task!
  deleteTaskList(id: ID!): Boolean!
  """Hard-delete a Task and every nested subtask. Transactional."""
  detachLabel(taskID: ID!, labelID: ID!): Task!
  moveTask(taskID: ID!, status: String!, position: Float!): Task!
  moveTaskToList(taskID: ID!, ownerListID: ID!): Task!
  restoreTask(taskID: ID!): Task!
  updateTask(id: ID!, input: UpdateTaskInput!): Task!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
